import {defineConfig} from 'vite'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
      plugins: [tailwindcss(),],
      build: {
        outDir:"src/main/resources/static/",
        rollupOptions: {
          input: {
            common: "style/common.css"
          },
          output: { // entry chunk assets それぞれの書き出し名の指定
            assetFileNames: (config) => {
              if (config.name?.endsWith(".js")) return `script/${config.name}`
              if (config.name?.endsWith(".css")) return `css/${config.name}`
              if ([
                ".png"
              ].find((ext) => {
                return config.name?.toLowerCase()?.endsWith(ext)
              })) return `images/${config.name}`
              return `assets/${config.name}` || "undefined"
            }
          },
        },
        cssCodeSplit: true,
        cssMinify: false,
      },
    }
)