## travis yml 에 대하여
```yaml
sudo: required

language: generic

services:
  - docker

before_install:
  - echo "start creating an image with dockerfile"
  - docker build -t jonsoku/docker-react-app -f Dockerfile.dev .

script:
  - docker run -e CI=true jonsoku/docker-react-app npm run test -- --coverage

deploy:
  edge: true
  provider: elasticbeanstalk
  region: ap-northeast-1
  app: docker-react-app
  env: Dockerreactapp-env
  bucket_name: elasticbeanstalk-ap-northeast-1-258215388708
  bucket_path: docker-react-app
  on:
    branch: master # 어떤 브랜치에 Push 를 할때 AWS 에 배포를 할 것인지
  access_key-id: $AWS_ACCESS_KEY
  secret_access_key: $AWS_SECRET_ACCESS_KEY

after_success:
  - echo "test success"
```

### deploy
배포에 관련 된 부분이다.
예제에서는 EB 를 사용했다. <br />
aws 관련 된 세팅을 하면된다. <br /> 
* `access_key_id`: IAM - 액세스 키 ID
* `secret_access_key` IAM - 비밀 액세스 키

IAM 에서 가져온 정보들을 travis setting 의 environment 에 정의한다.