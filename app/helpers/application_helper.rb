module ApplicationHelper
  def markdown(text)
    render_options = {
        filter_html:     true,
        hard_wrap:       true,
        link_attributes: { rel: 'nofollow' }
    }

    extensions = {
        autolink:           true,
        disable_indented_code_blocks: true,
        lax_spacing:        true,
        no_intra_emphasis:  true,
        strikethrough:      true,
        superscript:        true,
        underline:          true,
        highlight:          true,
        quote:              true,

    }

    renderer = Redcarpet::Render::HTML.new(render_options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
