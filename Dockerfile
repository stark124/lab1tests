FROM nginx:alpine

COPY app/index.html /usr/share/nginx/html/index.html

EXPOSE 80
<<<<<<< HEAD

CMD ["nginx", "-g", "daemon off;"]
=======
>>>>>>> e1ec15059a9572f9ab5a08683b7b4d8833a8ccfe
