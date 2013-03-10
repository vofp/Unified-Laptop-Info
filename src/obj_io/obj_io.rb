def load_obj(filename)
    File.open(filename,'r') do|file|
        return Marshal.load(file)
    end
end

def save_obj(filename, data)
    File.open(filename,'w') do|file|
        Marshal.dump(data, file)
    end
end
