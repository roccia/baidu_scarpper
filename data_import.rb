require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection(
    adapter:  'mysql2',
    database: 'PDF',
    username: 'meiuser',
    password: '_m3iu$er_',
    host:     'localhost'
)


class DataImport < ActiveRecord::Base


end
class Test < ActiveRecord::Base


end

p Test.first
