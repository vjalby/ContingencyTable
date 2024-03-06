
# This file is a generated template, your changes will not be overwritten

contingencytableClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "contingencytableClass",
    inherit = contingencytableBase,
    private = list(
        .run = function() {

            # `self$data` contains the data
            # `self$options` contains the options
            # `self$results` contains the results object (to populate)
            private$.contingencytable(self$data, self$options$rowVar, self$options$colVar)->tableData
            self$results$text$setContent(tableData)
          if (self$options$generate)
            private$.generate(tableData)
        },
        .generate = function(tableData) {
            #private$.contingencytable(self$data, self$options$rowVar, self$options$colVar)->tableData
            #self$results$text$setContent(tableData)
            afilename<-tempfile(fileext = ".omv")
            jmvReadWrite::write_omv(data.frame(tableData),afilename)
            where<-Sys.info()["sysname"]
            switch (where,
                  Windows = {
                    dirs<-dir("C://Program Files")
                    w<-grep("jamovi",dirs,fixed=T)
                    j<-dirs[w]
                    cmd<-paste0('C:\\Program Files\\',j,'\\bin\\jamovi')
                    arg<-paste(afilename, "--title='Untitled' --temp")
                    system2(cmd,args=arg,stderr = T,stdout = T)     
                  },
                  Linux= {
                    cmd<-paste("/app/bin/jamovi ",afilename, "--title='Untitled' --temp")
                    system(cmd,ignore.stdout = F,ignore.stderr = F)
                  },
                  Darwin= {
                    cmd <- paste(R.home(), '../../../../../MacOS/jamovi', sep='/')
                    arg<-paste(afilename, "--title='Untitled' --temp")
                    result<-system2(cmd,args=arg,stderr = T,stdout = T)     
                  }
            )
        },
        .contingencytable = function(data, aRow, aCol) {
            as.data.frame.matrix(table(data[,aRow],data[,aCol]))->tableData
            cbind(rownames(tableData), tableData) -> tableData
            rownames(tableData) <- NULL 
            colnames(tableData)[1] <- aRow
            return(tableData)
        })
)
