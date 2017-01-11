require_relative "../fda"

RSpec.describe "QueryFDA" do


    before(:example) do
        @query = QueryFDA.new
    end

	context "accessing url" do
      it "receives a json object from url" do
        expect(@query.fda_query).to_not eq nil
      end
    end
    
    context "parsing the data" do
        it "can parse it" do
            parse = @query.parse_json 
            expect(parse).to_not eq nil
        end

        it "can organise/filter data" do
            data = @query.organise_data
            expect(data).to_not eq nil
        end
    end
    

    context "displays data" do
        it "outputs formatted data" do
            output = @query.display_results 
            expect(output.length).to eq 5
        end
    end    
end
