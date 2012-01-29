
namespace :spree_warehouse do 
  namespace :db do 

    user_roles = ['stocker','packager','shipper']

    desc "inserts spree_warehouse user roles in the db" 
    task :seed_roles => :environment do  
      puts "Executing seed_roles task"
      created_roles = 0 
      user_roles.each do |role| 
        found_role = Spree::Role.find_by_name(role) 
        if found_role 
          puts "'#{found_role.name}' role already exists , skipping ..."
        else 
          created_roles += 1
          created_role = Spree::Role.create(:name => role)
          puts "'#{role}' role created" if created_role
        end
      end 
      if created_roles != 0 
        puts "Created #{created_roles} roles!"
      else
        puts "No roles created, they already exist!"
      end
    end 
    

    desc "removes spree_warehouse user roles from the db" 
    task :remove_roles => :environment do 
      puts "Executing remove_roles task"
      found_roles = 0
      user_roles.each do |role| 
        found_role = Spree::Role.find_by_name(role)
        if found_role
          found_roles += 1
          puts "Removing '#{found_role.name}' role" 
          found_role.destroy
        else 
          puts "'#{role}' role not found"
        end
      end 
      if found_roles != 0 
        puts "Removed #{found_roles} roles!"
      else
        puts "No roles removed!"
      end
    end 

  end 
end
