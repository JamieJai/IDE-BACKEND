# gradle과 JDK를 포함하는 이미지 사용
FROM krmp-d2hub-idock.9rum.cc/goorm/gradle:7.3.1-jdk17

# 작업 디렉토리 설정
WORKDIR /home/gradle/project

# 소스코드 복사
COPY . .

# gradlew를 이용한 프로젝트 빌드
RUN echo "systemProp.http.proxyHost=krmp-proxy.9rum.cc\nsystemProp.http.proxyPort=3128\nsystemProp.https.proxyHost=krmp-proxy.9rum.cc\nsystemProp.https.proxyPort=3128" > /root/.gradle/gradle.properties
RUN ./gradlew clean build -x test

ENV DATABASE_URL=jdbc:mysql://mysql:3306/everyide

# 빌드 결과 jar 파일을 실행
CMD ["java", "-jar", "/home/gradle/project/build/libs/web-ide-0.0.1-SNAPSHOT.jar"]


#------ 일반 도커파일
# gradle과 JDK를 포함하는 이미지 사용
#FROM gradle:7.3.1-jdk17 AS build

# 작업 디렉토리 설정
#WORKDIR /home/gradle/project

# 소스코드 복사
#COPY --chown=gradle:gradle . .

# gradlew를 이용한 프로젝트 빌드
#RUN ./gradlew clean build -x test

# 최종 실행 이미지
#FROM openjdk:17
#WORKDIR /app
#COPY --from=build /home/gradle/project/build/libs/web-ide-0.0.1-SNAPSHOT.jar /app/
#COPY --from=build /home/gradle/project/src/main/resources/secret.properties /app/

# 빌드 결과 jar 파일을 실행
#CMD ["java", "-jar", "web-ide-0.0.1-SNAPSHOT.jar"]
