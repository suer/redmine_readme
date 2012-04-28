class ReadmeListener < Redmine::Hook::ViewListener
  MARKDOWN_EXTENSIONS = %w(.markdown .md .mkd .mdown .mkdn)

  def view_projects_show_left(context)
    html = ''
    context[:project].repositories.each do |repository|
      next if repository.nil? or repository.entries.nil?
      entry = repository.entries.find{|e| e.name =~ /README((\.).*)?/i}
      next if entry.nil?
      text = repository.cat(entry.path)
      formatter_name = '' # name for NullFormatter
      if MARKDOWN_EXTENSIONS.include?(File.extname(entry.path))
        formatter_name = Redmine::WikiFormatting.format_names.find {|name| name =~ /Markdown/}
      end
      formatter = Redmine::WikiFormatting.formatter_for(formatter_name).new(text)
      html << context[:controller].send(:render_to_string, {
        :partial => 'readme/left',
        :locals => {:repository => repository, :html => formatter.to_html}
      })
    end
    html
  end
end
