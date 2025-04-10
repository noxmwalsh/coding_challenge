// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "./application"

// Register all controllers in the controllers directory
const controllers = import.meta.glob("./**/*_controller.js", { eager: true })
Object.values(controllers).forEach((controller) => {
  if (typeof controller.default === "function") {
    application.register(controller.name, controller.default)
  }
})
