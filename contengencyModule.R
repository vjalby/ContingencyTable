install.packages('jmvtools', repos=c('https://repo.jamovi.org', 'https://cran.r-project.org'))
jmvtools::check()

jmvtools::create('ContingencyTable')

jmvtools::addAnalysis(name='contingencytable', title='Contingency Table')

jmvtools::install()


