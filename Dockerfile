# Multiphase image

# Create a temporary image
FROM node:alpine
WORKDIR  '/app'
COPY package.json .
RUN npm install
COPY . .
# - no need to configure volumes because, in production, we don't want live reloading
CMD ["npm", "run", "build"]

# Create the actual image, which uses elements created in the temporary image above
# - every FROM instruction implicitly stops the previous block
FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html
# - no need to start nginx because it is already done by the nginx base image
