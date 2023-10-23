plugins {
    id("java")
    id("idea")
    antlr
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.jetbrains:annotations:24.0.1")
    antlr("org.antlr:antlr4:4.12.0")

    implementation("org.springframework.boot:spring-boot-starter-web:2.5.5") {
        exclude(module = "spring-boot-starter-tomcat")
    }
    implementation("org.springframework.boot:spring-boot-starter-jetty:2.5.5")
    implementation("org.springframework.boot:spring-boot-starter-data-jpa:2.5.5")
    implementation("org.springframework.boot:spring-boot-starter-actuator:2.5.5")

    implementation("org.hibernate:hibernate-core:5.5.7.Final")
    implementation("org.hibernate:hibernate-entitymanager:5.5.7.Final")
    implementation("org.postgresql:postgresql:42.6.0")
    implementation("javax.xml.bind:jaxb-api:2.3.1")

    implementation("com.fasterxml.jackson.core:jackson-databind:2.15.1")

    implementation("com.google.code.gson:gson:2.10.1")

    testImplementation("org.junit.jupiter:junit-jupiter-api:5.9.2")
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:5.9.2")
}
java {
    sourceCompatibility = JavaVersion.VERSION_14
    targetCompatibility = JavaVersion.VERSION_14
}

tasks {
    generateGrammarSource {
        maxHeapSize = "256m"
        arguments = arguments + listOf("-visitor", "-long-messages")
    }

    getByName<Test>("test") {
        useJUnitPlatform()
    }
    compileJava {
        dependsOn("generateGrammarSource")
    }
    compileTestJava {
        dependsOn("generateGrammarSource")
    }
}