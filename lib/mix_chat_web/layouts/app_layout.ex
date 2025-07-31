defmodule MixChatWeb.AppLayout do
  use Hologram.Component

  def template do
    ~HOLO"""
    <html>
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>MixChat</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <Hologram.UI.Runtime />
      </head>
      <body>
        <slot />
      </body>
    </html>
    """
  end
end