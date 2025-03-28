#Chose the image which has node installed already 
FROM node:alpine

#Copy all the files from current directory to the container
COPY ./ ./

#Install the project dependencies like the npm
RUN npm install

#Expose a port for the application
EXPOSE 8080

#Default command to launch the application
CMD ["npm", "start"]
