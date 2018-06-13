sudo npm install -g now
echo "Deploying to qa environment..."
URL=$(now --docker --public -t $NOW_TOKEN)
echo "Running acceptance on $URL"
curl --silent -L $URL
