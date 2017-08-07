require 'nokogiri'
topics = ''
comments = ''

comment_id = 1
xml = Nokogiri::XML(ARGF)
xml.xpath('/feed/doc').first(1000000).each_with_index do |doc, idx|
  next unless doc

  now = Time.now.utc.strftime('%Y-%m-%d %H:%M:%S')

  topic_id = (idx+1)
  title = doc.xpath('title').first.inner_text
  title.gsub!(/\AWikipedia: /, '')
  title.gsub!('"', ' ')

  topics << [topic_id.to_s, title, now, now].join("\t")
  topics << "\n"

  anchors = doc.xpath('links/sublink/anchor').map {|a| a.inner_text }
  [doc.xpath('abstract').first.inner_text, *anchors].each do |body|
    body.gsub!("\t", ' ')
    body.gsub!('"', ' ')
    comments << [comment_id.to_s, body, '1', topic_id.to_s, now, now].join("\t")
    comments << "\n"

    comment_id += 1
  end
end

File.write(File.expand_path('../tmp/topics.tsv', __dir__), topics)
File.write(File.expand_path('../tmp/comments.tsv', __dir__), comments)

puts <<-EODOC
> .separator "\t"
> .import tmp/topics.tsv topics
> .import tmp/comments.tsv comments
EODOC
