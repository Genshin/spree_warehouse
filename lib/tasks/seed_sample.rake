namespace :spree_warehouse do 
  namespace :sample do
    
    container_taxonomies = [ { :name => 'Shelve#1'}, { :name => 'Shelve#2'}, { :name => 'Shelve#3'} ]
    container_taxons = ['A','B','C']
    visual_code_types = [ {:name => "Barcode", :can_delete => false}, {:name => "QR Code" , :can_delete => false} ]

    desc "Seeds all spree_warehouse sample_data into the DB"
    task :seed => :environment do
      puts "Executing spree_warehouse:sample:seed task" 
      [ "sample:seed_container_taxonomies", "sample:seed_container_taxons"].each do |task|
         task = "spree_warehouse:" + task
         puts "\n"
         Rake::Task[task].execute
      end
    end


    desc "Removes all spree_warehouse sample seed data from the DB"
    task :remove_seed => :environment do
      puts "Executing spree_warehouse:sample:remove_seed task" 
      ["sample:remove_container_taxons","sample:remove_container_taxonomies"].each do |task|
         task = "spree_warehouse:" + task
         puts "\n"
         Rake::Task[task].execute
      end
    end


    desc "Inserts spree_warehouse sample container taxonomies into the DB" 
    task :seed_container_taxonomies => :environment do  
      puts "Executing spree_warehouse:sample:seed_container_taxonomies task"
      created_cts = 0 
      container_taxonomies.each do |ct| 
        found_ct = Spree::ContainerTaxonomy.find_by_name(ct[:name]) 
        if found_ct 
          puts "'#{found_ct.name}' already exists , skipping ...".foreground(:yellow)
        else 
          created_cts += 1
          created_ct = Spree::ContainerTaxonomy.create(ct)
          puts "'#{ct[:name]}' created".foreground(:green) if created_ct
        end
      end 
      if created_cts != 0 
        puts "Created #{created_cts} container taxonomies!".background(:green)
      else
        puts "No container taxonomies created, they already exist!".background(:red)
      end
    end 


    desc "Removes spree_warehouse sample container taxonomies from the DB" 
    task :remove_container_taxonomies => :environment do 
      puts "Executing spree_warehouse:sample:remove_container_taxonomies task"
      found_cts = 0
      container_taxonomies.each do |ct| 
        found_ct = Spree::ContainerTaxonomy.find_by_name(ct[:name])
        if found_ct
          found_cts += 1
          puts "Removing '#{found_ct.name}'".foreground(:green) 
          found_ct.destroy
        else 
          puts "'#{ct[:name]}' not found".foreground(:yellow)
        end
      end 
      if found_cts != 0 
        puts "Removed #{found_cts} container taxonomies!".background(:green)
      else
        puts "No container taxonomies removed!".background(:red)
      end
    end 
    
    desc "Inserts spree_warehouse sample container taxons into the DB" 
    task :seed_container_taxons => :environment do  
      puts "Executing spree_warehouse:sample:seed_container_taxons task"
      created_cts = 0 
      
      
      container_taxonomies.each_with_index do |container_taxonomy_name, container_taxonomy_index|
        container_taxonomy = Spree::ContainerTaxonomy.find_by_name(container_taxonomy_name[:name]) 
        puts "Container taxonomy : #{container_taxonomy[:name]}"
        
        parent_container_taxon_name = ''
        parent_container_taxon = nil
        
        container_taxons.each_with_index do |ct, ct_index| 
          parent_container_taxon = Spree::ContainerTaxon.create(:name => "#{ct}", :container_taxonomy => container_taxonomy) if ct_index == 0
          
          5.times do |i|
            container_taxon = { :name => "#{ct}_#{container_taxonomy_index}##{i}", :container_taxonomy => container_taxonomy , :parent_id => parent_container_taxon.id}

            found_ct = Spree::ContainerTaxon.find_by_name(container_taxon[:name]) 
            if found_ct 
              puts "'#{found_ct.name}' already exists , skipping ...".foreground(:yellow)
              else 
                created_cts += 1
                created_ct = Spree::ContainerTaxon.create(container_taxon)
                puts "'#{container_taxon[:name]}' created".foreground(:green) if created_ct
              end
           
          end
        end
      end 
      
      if created_cts != 0 
        puts "Created #{created_cts} container taxons!".background(:green)
      else
        puts "No container taxons created, they already exist!".background(:red)
      end
      
    end 
    
    #TODO Fix the printing
    desc "Removes spree_warehouse sample container taxons from the DB" 
    task :remove_container_taxons => :environment do 
      puts "Executing spree_warehouse:sample:remove_container_taxons task"
      found_cts = 0
      container_taxonomies.each_with_index do |container_taxonomy, container_taxonomy_index| 
        container_taxons.each_with_index do |ct, ct_index| 
          found_parent_ct = Spree::ContainerTaxon.find_by_name(ct)
          if found_parent_ct 
            found_cts += 1
            puts "Removing '#{found_parent_ct.name}'".foreground(:green) 
            found_parent_ct.destroy
          else 
            puts "'#{ct}' not found".foreground(:yellow)
          end
          
          5.times do |i|          
            container_taxon = { :name => "#{ct}_#{container_taxonomy_index}##{i}"}
            found_ct = Spree::ContainerTaxon.find_by_name(container_taxon[:name]) 
            if found_ct 
              found_cts += 1
              puts "Removing '#{found_ct.name}'".foreground(:green) 
              found_ct.destroy
            else 
              puts "'#{container_taxon[:name]}' not found".foreground(:yellow)
            end
          end
        end
      end
      if found_cts != 0 
        puts "Removed #{found_cts} container taxons!".background(:green)
      else
        puts "No container taxons removed!".background(:red)
      end
    end
    

  end
end
