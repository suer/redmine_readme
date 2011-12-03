class ReadmeListener < Redmine::Hook::ViewListener
  def view_projects_show_left(context)
    repository = context[:project].repository
    return '' if repository.nil? or repository.entries.nil?
    repository.fetch_changesets if Setting.autofetch_changesets?
    entry = repository.entries.find{|e| e.name =~ /README((\.).*)?/}
    return '' if entry.nil?
    
    text = repository.cat(entry.path)
    formatter_name = '' # name for NullFormatter
    if File.extname(entry.path) == '.markdown'
      formatter_name = Redmine::WikiFormatting.format_names.find {|name| name =~ /Markdown/}
    end
    formatter = Redmine::WikiFormatting.formatter_for(formatter_name).new(text)
    context[:controller].send(:render_to_string, {
        :partial => 'readme/left',
        :locals => {:html => formatter.to_html}
      })
  end
end
