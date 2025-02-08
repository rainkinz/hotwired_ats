import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import tailwindcss from "@tailwindcss/vite"
import FullReload from 'vite-plugin-full-reload'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    tailwindcss(),
    FullReload(['config/routes.rb', 'config/initializers/simple_form.rb', 'app/views/**/*'])
  ],
})
