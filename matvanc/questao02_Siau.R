#------------------QUESTÃO 01 - Item A---------------------------------------

getwd()
setwd("/Users/pedrosiau/Desktop")
alunos<-read.csv("Edu-Data.csv")
summary(alunos)

gender<-table(alunos$gender)
nationality<-table(alunos$NationalITy)
placeofBirth<-table(alunos$PlaceofBirth)
stageID<-table(alunos$StageID)
gradeID<-table(alunos$GradeID)
sectionID<-table(alunos$SectionID)
topic<-table(alunos$Topic)
semester<-table(alunos$Semester)
relation<-table(alunos$Relation)
parentSurvey<-table(alunos$ParentAnsweringSurvey)
parentSatisfaction<-table(alunos$ParentschoolSatisfaction)
studentAbsence<-table(alunos$StudentAbsenceDays)
class<-table(alunos$Class)

mytable<-function(data){
#f é a frequencia
#F é a frequencia acumulada
#fr é a frequencia relativa
#fra é a frequencia relativa acumulada
  f<-data
  F<-cumsum(f)
  fr<-f/sum(f)
  fra<-cumsum(fr)
  
  dist1<-cbind(f,F,fr,fra)
  
  total<-c(sum(f),NA,sum(fr),NA)
  
  dist2<-rbind(dist1,total)
  
  return(dist2)
}

table_gender<-mytable(gender)
table_Nationality<-mytable(nationality)
table_PlaceofBirth<-mytable(placeofBirth)
table_stageID<-mytable(stageID)
table_gradeID<-mytable(gradeID)
table_sectionID<-mytable(sectionID)
table_topic<-mytable(topic)
table_semester<-mytable(semester)
table_relation<-mytable(relation)
table_parentSurvey<-mytable(parentSurvey)
table_parentSatisfaction<-mytable(parentSatisfaction)
table_studentAbsence<-mytable(studentAbsence)
table_class<-mytable(class)

?
write.table(table_gender,"/Users/pedrosiau/Desktop/gender.txt",sep="\t")
write.table(table_Nationality,"/Users/pedrosiau/Desktop/nationality.txt",sep="\t")
write.table(table_PlaceofBirth,"/Users/pedrosiau/Desktop/placeofBirth.txt",sep="\t")
write.table(table_stageID,"/Users/pedrosiau/Desktop/stageID.txt",sep="\t")
write.table(table_gradeID,"/Users/pedrosiau/Desktop/gradeID.txt",sep="\t")
write.table(table_sectionID,"/Users/pedrosiau/Desktop/sectionID.txt",sep="\t")
write.table(table_topic,"/Users/pedrosiau/Desktop/topic.txt",sep="\t")
write.table(table_semester,"/Users/pedrosiau/Desktop/semester.txt",sep="\t")
write.table(table_relation,"/Users/pedrosiau/Desktop/relation.txt",sep="\t")
write.table(table_parentSurvey,"/Users/pedrosiau/Desktop/parentSurvey.txt",sep="\t")
write.table(table_parentSatisfaction,"/Users/pedrosiau/Desktop/parentSatisfaction.txt",sep="\t")
write.table(table_studentAbsence,"/Users/pedrosiau/Desktop/studentAbsence.txt",sep="\t")
write.table(table_class,"/Users/pedrosiau/Desktop/class.txt",sep="\t")


#--------------------Questão 2-Item b----------------------------
grafico_barra<-function(data,eixo_x){
  barplot(data,main="Gráfico de Barras\n", 
          ylab= "Frequência", xlab=eixo_x, col=c(1:length(data)))
}

grafico_pizza<-function(data,nome,titulo){
  pie(data,labels=c(levels(nome)), main=titulo,col=c(1:length(data)))
}

grafico_pizza(gender,alunos$gender,"Sexo")
grafico_pizza(nationality,alunos$NationalITy,"Nacionalidade")
grafico_pizza(placeofBirth,alunos$PlaceofBirth,"Local de Nascimento")
grafico_pizza(stageID,alunos$StageID,"stageID")
grafico_pizza(gradeID,alunos$GradeID,"gradeID")
grafico_pizza(sectionID,alunos$SectionID,"Seção")
grafico_pizza(topic,alunos$Topic,"Matérias")
grafico_pizza(semester,alunos$Semester,"Semeste")
grafico_pizza(relation,alunos$Relation,"Parente Responsável")
grafico_pizza(parentSurvey,alunos$ParentAnsweringSurvey,"Responsável respondeu a pesquisa?")
grafico_pizza(parentSatisfaction,alunos$ParentschoolSatisfaction,"Satisfação dos pais")
grafico_pizza(studentAbsence,alunos$StudentAbsenceDays,"Faltas")
grafico_pizza(class,alunos$Class,"Turma")

grafico_barra(gender,"Sexo")
grafico_barra(nationality,"Nacionalidade")
grafico_barra(placeofBirth,"Local de Nascimento")
grafico_barra(stageID,"stageID")
grafico_barra(gradeID,"gradeID")
grafico_barra(sectionID,"Seção")
grafico_barra(topic,"Matérias")
grafico_barra(semester,"Semestre")
grafico_barra(relation,"Parente Responsável")
grafico_barra(parentSurvey,"Responsável respondeu a pesquisa?")
grafico_barra(parentSatisfaction,"Satisfação dos Pais")
grafico_barra(studentAbsence,"Faltas")
grafico_barra(class,"Turma")
