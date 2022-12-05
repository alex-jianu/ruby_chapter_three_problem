require 'date'

class PasswordManager2
    def initialize
        @all_entries = []
    end

    def add(new_service, new_password)
        if @all_entries.any?{|entry| entry["service"] == new_service}
            return "ERROR: Service names must be unique"
        elsif @all_entries.any?{|entry| entry["password"] == new_password}
            return "ERROR: Passwords must be unique"
        else
            new_entry = {"service" => new_service, "password" => new_password, "added_on" => DateTime.now(), "updated" => DateTime.now()}
            @all_entries.push(new_entry)
        end
    end

    def remove(service_name)
        entry_to_be_removed = @all_entries.find{|entry| entry["service"] == service_name}
        @all_entries.delete(entry_to_be_removed)
    end

    def services
        return @all_entries.map{|entry| entry["service"]}
    end

    def sort_by(sorting_method)
        sorted_entries = @all_entries.sort_by{|entry| entry[sorting_method]}
        return sorted_entries.map{|entry| entry["service"]}
    end

    def password_for(service_name)
        searched_entry =  @all_entries.find{|entry| entry["service"] == service_name}
        return searched_entry["password"]
    end

    def update(service_name, new_password)
        if @all_entries.any?{|entry| entry["password"] == new_password}
            return "ERROR: Passwords must be unique"
        else
            @all_entries.find{|entry| entry["service"] == service_name}["password"] = new_password
            @all_entries.find{|entry| entry["service"] == service_name}["updated"] = DateTime.now()
        end
    end
end
