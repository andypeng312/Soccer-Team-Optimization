import urllib2,re,collections

def getname(page):
	b4name='<h1 itemprop="name">'
	fname=re.search('(?<='+b4name+').+?(?=<b>)',page).group(0)
	lname=re.search('(?<='+fname+'<b>).+?(?=</b></h1>)',page).group(0)
	return fname+lname

def getpreffoot(page):
	b4preffoot='<tr>\r\n\t\t\t\t\t\t\t\t\t<th>Foot:</th>\r\n\t\t\t\t\t\t\t\t\t<td>'
	preffoot=re.search('(?<='+b4preffoot+').+?(?=</td>)',page).group(0)
	return preffoot

def getbirthdate(page):
	b4birthdate='<span itemprop="birthDate" class="dataValue">\r\n                                    '
	birthdate=re.search('(?<='+b4birthdate+').+?(?=     )',page).group(0).replace(',','')
	return birthdate

def getmv(page):
	aftermv=' <span class="waehrung">'
	mv=re.search('(?<=">).+?(?='+aftermv+')',page).group(0)
	mv=float(mv.replace(',','.'))
	mv2=re.search('(?<='+aftermv+').+?(?=. )',page).group(0)
	print repr(mv2)
	if (mv2=='Mill'):
		mv*=10**6
	elif (mv2=='Th'):
		mv*=10**3
	return mv

def writetofile(playerstats, i):
	f=open('stats_mv.csv','a+')
	filestring=''
	h=False if (i==1) else True
	h_string=''
	for player in playerstats:
		for stat in player:
			if (not h):
				h_string+=stat+', '
			filestring+=str(player[stat])+', '
		if (not h):
			h=True
			filestring=h_string+'\n'+filestring
		filestring+='\n'
	f.write(filestring)
	f.close()

def main():
	opener = urllib2.build_opener()
	opener.addheaders = [('User-Agent', 'Mozilla/5.0')]
	playerstats=[]
	init_url='http://www.transfermarkt.com/a/profil/spieler/'
	for i in range(75979,99998): #99997 pages
	#####################################change this number^
		print i
		pagen=str(i)
		fail=True
		while fail:
			for j in range(100):
				try:
					page=opener.open(init_url+pagen).read()
					fail=False
					break
				except:
					continue
			if fail:
				try:
					input('Please check the internet...')
				except:
					continue
			else:
				break
		player=collections.OrderedDict()
		try:
			player['Name']=getname(page)
			player['Preferred Foot']=getpreffoot(page)
			player['Birth Date']=getbirthdate(page)
			player['Market Value']=getmv(page)
		except:
			continue
		playerstats.append(player)
		print player['Name']
		writetofile(playerstats,i)
		playerstats=[]
main()
