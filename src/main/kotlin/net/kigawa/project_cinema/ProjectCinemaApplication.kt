package net.kigawa.project_cinema

import org.springframework.boot.autoconfigure.SpringBootApplication

@SpringBootApplication
class ProjectCinemaApplication

fun main(args: Array<String>) {
  ProjectCinemaInitializer(args).start()
}
