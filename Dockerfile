# to build
#    docker build . -t commander
# to run 
#    docker run -it commander  -e opc.tcp://localhost:26543

FROM node:20-alpine

WORKDIR /opt/opcuacommander
RUN npm config set registry http://registry.npmjs.org/
RUN npm install -g typescript 

COPY package*.json ./
RUN npm ci --mit=dev --unsafe-perm=true --allow-root 

COPY . .
RUN npm run build

VOLUME [ "/root/.config/opcua-commander-nodejs/pki" ]
ENTRYPOINT [ "./bin/opcua-commander" ]
