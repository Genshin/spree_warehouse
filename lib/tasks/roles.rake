
namespace :spree_warehouse do 
  namespace :db do 
    desc "inserts spree_warehouse user roles" 
    task :seed_roles => :environment do 
      user_roles = ['stocker','packager','shipper'] 
      user_roles.each do |role| 
        Spree::Role.find_or_create_by_name(role) 
      end 
    end 
  end 
end
