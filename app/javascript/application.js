// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "chartkick/chart.js"
import Chart from "chart.js/auto"
Chartkick.use(Chart)