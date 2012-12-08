module ApplicationHelpers

  def development?
    environment == :development
  end

  def body_classes
    (@body_classes || []).join(" ")
  end

  def add_body_class(body_class)
    @body_classes ||= []
    @body_classes << body_class
    @body_classes
  end

  def js_settings
    client_settings = {}
    client_settings["debug_mode"] = development?

    if development?
      mixpanel_settings = {}
    else
      mixpanel_settings = data.try(:mixpanel) || {}
    end

    %{
      <script type="text/javascript" charset="utf-8">
        window.Settings = {};
        Settings.env = "#{environment}";
        Settings.mixpanel = #{mixpanel_settings.to_json}
        Settings.client = #{client_settings.to_json};
      </script>
    }.html_safe
  end

end