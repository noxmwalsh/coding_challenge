// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "./application"

// Manually import and register each controller
import HelloController from "./hello_controller"
application.register("hello", HelloController)
