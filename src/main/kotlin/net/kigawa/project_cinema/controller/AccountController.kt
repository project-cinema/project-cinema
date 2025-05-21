package net.kigawa.project_cinema.controller

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping

@Controller
class AccountController {
  @GetMapping("/mypage")
  fun account(): String {
    return "mypage"
  }
}