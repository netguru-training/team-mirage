
[1mFrom:[0m /home/q/RubymineProjects/untitled1/team-mirage/app/controllers/projects_controller.rb @ line 7 ProjectsController#create:

     [1;34m6[0m: [32mdef[0m [1;34mcreate[0m
 =>  [1;34m7[0m:   binding.pry
     [1;34m8[0m:   project.owner = current_user
     [1;34m9[0m:   [32mif[0m project.save
    [1;34m10[0m: 
    [1;34m11[0m:     redirect_to project_path(project), [35mnotice[0m: [31m[1;31m'[0m[31mProject has been created[1;31m'[0m[31m[0m
    [1;34m12[0m:   [32melse[0m
    [1;34m13[0m:     render [33m:new[0m
    [1;34m14[0m:   [32mend[0m
    [1;34m15[0m: [32mend[0m

