# to build
#    docker build . -t commander
# to run 
#    docker run -it commander -e opc.tcp://localhost:26543

ARG NODE_IMAGE=node:22-alpine

FROM ${NODE_IMAGE} AS build

WORKDIR /opt/opcuacommander

COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci

COPY . .
RUN npm run build

FROM ${NODE_IMAGE}

WORKDIR /opt/opcuacommander
COPY --from=build /opt/opcuacommander/bin ./bin

VOLUME [ "/root/.config/opcua-commander-nodejs/pki" ]
ENTRYPOINT [ "./bin/opcua-commander.js" ]
