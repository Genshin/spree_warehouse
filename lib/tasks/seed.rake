namespace :spree_warehouse do 
  namespace :db do 
    
    user_roles = ['stocker','packager','shipper']
    visual_code_types = [ {:name => "Barcode"}, {:name => "QR Code"} ]

    desc "Seeds all spree_warehouse data into the DB"
    task :seed => :environment do
      puts "Executing spree_warehouse seed task" 
      [ "db:seed_roles", "db:seed_visual_code_types" ].each do |task|
         task = "spree_warehouse:" + task
         puts "\n"
         Rake::Task[task].execute
      end
    end


    desc "Removes all spree_warehouse seed data from the DB"
    task :remove_seed => :environment do
      puts "Executing spree_warehouse remove_seed task" 
      [ "db:remove_roles", "db:remove_visual_code_types" ].each do |task|
         task = "spree_warehouse:" + task
         puts "\n"
         Rake::Task[task].execute
      end
    end


    desc "Inserts spree_warehouse visual code types into the DB" 
    task :seed_visual_code_types => :environment do  
      puts "Executing seed_visual_code_types task"
      created_vcts = 0 
      visual_code_types.each do |vct| 
        found_vct = Spree::VisualCodeType.find_by_name(vct[:name]) 
        if found_vct 
          puts "'#{found_vct.name}' already exists , skipping ...".foreground(:yellow)
        else 
          created_vcts += 1
          created_vct = Spree::VisualCodeType.create(vct)
          puts "'#{vct[:name]}' created".foreground(:green) if created_vct
        end
      end 
      if created_vcts != 0 
        puts "Created #{created_vcts} visual code types!".background(:green)
      else
        puts "No visual code types created, they already exist!".background(:red)
      end
    end 


    desc "Removes spree_warehouse visual code types from the DB" 
    task :remove_visual_code_types => :environment do 
      puts "Executing remove_visual_code_types task"
      found_vcts = 0
      visual_code_types.each do |vct| 
        found_vct = Spree::VisualCodeType.find_by_name(vct[:name])
        if found_vct
          found_vcts += 1
          puts "Removing '#{found_vct.name}'".foreground(:green) 
          found_vct.destroy
        else 
          puts "'#{vct[:name]}' not found".foreground(:yellow)
        end
      end 
      if found_vcts != 0 
        puts "Removed #{found_vcts} visual code types!".background(:green)
      else
        puts "No visual code types removed!".background(:red)
      end
    end 


    desc "Inserts spree_warehouse user roles into the DB" 
    task :seed_roles => :environment do  
      puts "Executing seed_roles task"
      created_roles = 0 
      user_roles.each do |role| 
        found_role = Spree::Role.find_by_name(role) 
        if found_role 
          puts "'#{found_role.name}' role already exists , skipping ...".foreground(:yellow)
        else 
          created_roles += 1
          created_role = Spree::Role.create(:name => role)
          puts "'#{role}' role created".foreground(:green) if created_role
        end
      end 
      if created_roles != 0 
        puts "Created #{created_roles} roles!".background(:green)
      else
        puts "No roles created, they already exist!".background(:red)
      end
    end 
    

    desc "Removes spree_warehouse user roles from the DB" 
    task :remove_roles => :environment do 
      puts "Executing remove_roles task"
      found_roles = 0
      user_roles.each do |role| 
        found_role = Spree::Role.find_by_name(role)
        if found_role
          found_roles += 1
          puts "Removing '#{found_role.name}' role".foreground(:green) 
          found_role.destroy
        else 
          puts "'#{role}' role not found".foreground(:yellow)
        end
      end 
      if found_roles != 0 
        puts "Removed #{found_roles} roles!".background(:green)
      else
        puts "No roles removed!".background(:red)
      end
    end 


  end 
end
