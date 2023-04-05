# Installing Golang 
sudo apt install wget
wget https://go.dev/dl/go1.20.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
rm go1.20.3.linux-amd64.tar.gz 

# Installing Docker
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Installing backend
mkdir backend && cd backend
git clone https://github.com/thelvv/db-project
cd db-project/
sudo docker build -t back1 .
sudo docker run -d -p 5000:5000 back1

# Fullfill DB
cd ..
git clone https://github.com/mailcourses/technopark-dbms-forum
cd technopark-dbms-forum/
go build
./technopark-dbms-forum fill --url=http://localhost:5000/api --timeout=900

