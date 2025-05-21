package net.kigawa.project_cinema.controller

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping

@Controller
class LpController {
  @GetMapping("/")
  fun top(): String {
    return "index"
  }
}