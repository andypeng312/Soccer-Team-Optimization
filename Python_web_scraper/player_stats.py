import urllib2,re,collections

def getname(page):
	b4name='''<div class="col-lg-5 col-sm-6">
            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title">'''
	name=re.search('(?<='+b4name+').+?(?= *<)',page)
	return name.group(0)

def getoverallrating(page, name):
	b4rating='<h3 class="panel-title">'+name+' <span class="pull-right"><span class="label rating r.">'
	rating=re.search('(?<='+b4rating+').+?(?=</span>)',page)
	return rating.group(0)

def getpotential(page, name, overall):
	b4pot='<h3 class="panel-title">'+name+' <span class="pull-right"><span class="label rating r.">'+overall+'</span> <span class="label rating r.">'
	pot=re.search('(?<='+b4pot+').+?(?=</span>)',page)
	return pot.group(0)

def getheight(page):
	b4height='<p>Height <span class="pull-right">'
	height=re.search('(?<='+b4height+').+?(?=</span></p>)',page)
	return height.group(0)

def getweight(page):
	b4weight='<p>Weight <span class="pull-right">'
	weight=re.search('(?<='+b4weight+').+?(?=</span></p>)',page)
	return weight.group(0)

def getpreffoot(page):
	b4preffoot='<p>Preferred Foot <span class="pull-right">'
	preffoot=re.search('(?<='+b4preffoot+').+?(?=</span></p>)',page)
	return preffoot.group(0)

def getbirthdate(page):
	b4birthdate='<p>Birth Date <span class="pull-right">'
	birthdate=re.search('(?<='+b4birthdate+').+?(?=</span></p>)',page)
	return birthdate.group(0)

def getage(page):
	b4age='<p>Age <span class="pull-right">'
	age=re.search('(?<='+b4age+').+?(?=</span></p>)',page)
	return age.group(0)

def getprefpos(page):
	b4prefpos='position ..">'
	prefpos=re.findall('(?<='+b4prefpos+').+?(?=</span></a>)',page)
	return str(tuple(pos for pos in prefpos)).replace(',',';')

def getworkrate(page):
	b4workrate='<p>Player Work Rate <span class="pull-right">'
	workrate=re.search('(?<='+b4workrate+').+?(?=</span></p>)',page)
	return workrate.group(0)

def getweakfoot(page):
	b4weakfoot='<p>Weak Foot <span class="pull-right">'
	weakfoot=re.search('(?<='+b4weakfoot+').+?(?=</span></p>)',page)
	return len(re.findall('fa-star ',weakfoot.group(0)))

def getskillmoves(page):
	b4skillmove='<p>Skill Moves <span class="pull-right">'
	skillmove=re.search('(?<='+b4skillmove+').+?(?=</span></p>)',page)
	return len(re.findall('fa-star ',skillmove.group(0)))

def getOtherStats(player,page):
	statString='<p>.+? <span class="pull-right"><span class="label rating r.">.+?</span></span></p>'
	m=re.findall(statString,page)
	for match in m:
		regexstatname='(?<=<p>).+?(?= <)'
		regexstat='(?<=r.">).+?(?=</span></span>)'
		statname=re.search(regexstatname,match)
		stat=re.search(regexstat,match)
		player[statname.group(0)]=stat.group(0)

def writetofile(playerstats, i):
	f=open('stats.csv','a+')
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
	playerstats=[]
	init_url='https://www.fifaindex.com'
	for i in range(1,590): #589 pages
		pagen='/players/'+str(i)+'/'
		page=urllib2.urlopen(init_url+pagen).read()
		matches=re.findall('(?<=<td data-title="Name"><a href=").*?(?=")',page)
		for link in matches[:-1]:
			player=collections.OrderedDict()
			page=urllib2.urlopen(init_url+link).read()
			player['Name']=getname(page)
			player['Overall Rating']=getoverallrating(page,player['Name'])
			player['Potential']=getpotential(page,player['Name'],player['Overall Rating'])
			player['Height']=getheight(page)
			player['Weight']=getweight(page)
			player['Preferred Foot']=getpreffoot(page)
			player['Birth Date']=getbirthdate(page)
			player['Age']=getage(page)
			player['Preferred Positions']=getprefpos(page)
			player['Player Work Rate']=getworkrate(page)
			player['Weak Foot']=getweakfoot(page)
			player['Skill Moves']=getskillmoves(page)
			getOtherStats(player,page.split('Ball Skills')[1])
			playerstats.append(player)
			print player['Name']
		writetofile(playerstats,i)
		playerstats=[];
		print i
main()