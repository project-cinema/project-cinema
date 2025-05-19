package net.kigawa.project_cinema

import org.springframework.boot.runApplication

class ProjectCinemaInitializer(
  private val args: Array<String>,
) {
  fun start() {

    runApplication<ProjectCinemaApplication>(*args) {
    }
  }

}