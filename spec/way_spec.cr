require "./spec_helper"

describe Way do
  it "read toml" do
    toml_string = %(
      title = "TOML Example"

      [owner]
      name = "Lance Uppercut"
      dob = 1979-05-27T07:32:00Z
    )

    toml = TOML.parse(toml_string)
    toml["title"].should eq("TOML Example")
    owner = toml["owner"].as(Hash)
    owner["name"].should eq("Lance Uppercut")
    owner["dob"].should eq(Time::Format::RFC_3339.parse("1979-05-27T07:32:00Z"))
  end
end
