N := app
S := vpn.snupt.com
C := asus

init:
	docker-compose run --rm $N ovpn_genconfig -u udp://$S
	docker-compose run --rm $N ovpn_initpki

up:
	docker-compose up -d

down:
	docker-compose down

logs:
	docker-compose logs -f

create-client:
	docker-compose run --rm $N easyrsa build-client-full $C nopass
	docker-compose run --rm $N ovpn_getclient $C > ./client/$C.ovpn

remove-client:
	docker-compose run --rm $N ovpn_revokeclient $C remove
