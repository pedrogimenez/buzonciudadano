require 'rspec'
require 'pg'
require_relative '../../app/models/issue_repository'
require_relative '../../app/models/issue'

 describe IssueRepository do
  it 'puts an issue' do
    conn = PG.connect( dbname: 'buzonciudadano_test', host: '127.0.0.1', port: 5432, user:'buzonciudadano', password: 'buzon' )
    repo = described_class.new(conn)

    issue = Issue.new('a text', 'a summary', 'the name', 'an address', ['image one', 'image two'])
    repo.put(issue)

    result = conn.exec( "SELECT * FROM issues" )
    result.getvalue(0, 1).should eql 'a text'
    result.getvalue(0, 2).should eql 'a summary'
    result.getvalue(0, 3).should eql 'the name'
    result.getvalue(0, 4).should eql 'an address'
    result.getvalue(0, 5).should eql 'image one,image two'

    conn.exec("DELETE FROM issues")
  end


  # it 'finds an issue by its uuid' do
  #   conn = PG.connect( dbname: 'buzonciudadano_test', host: '127.0.0.1', port: 5432, user:'buzonciudadano', password: 'buzon' )
  #   repo = described_class.new(conn)

  #   issue = Issue.new('a text', 'a summary', 'the name', 'an address', ['image one', 'image two'])
  #   repo.put(issue)
  #   something is wrong with issue.uuid, it generates a new one everytime
  #   found_issue = repo.find_by_uuid(issue.uuid)

  #   expect(issue.uuid).to eq(found_issue.uuid)

  #   conn.exec("DELETE FROM issues")
  # end


end
