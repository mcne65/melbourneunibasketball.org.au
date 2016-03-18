require 'spec_helper'

describe Member do
  describe "#age_and_gender" do
    let(:june_1_1990){ Date.new(1990, 6, 1) }
    let(:july_2_2013) { Date.new(2013, 7, 13) }
    subject{ Member.make(date_of_birth: june_1_1990, gender: "Male") }
    specify{ Timecop.freeze(july_2_2013) { subject.age_and_gender.should == '23yo male' }}
  end

  context "when members exist for multiple years" do
    let(:jan_31_2012){ Date.new(2012,  1, 31) }
    let(:mar_31_2012){ Date.new(2012,  3, 31) }
    let(:dec_31_2012){ Date.new(2012, 12, 31) }
    let(:jan_31_2013){ Date.new(2013,  1, 31) }
    let(:mar_31_2013){ Date.new(2013,  3, 31) }
    let(:dec_31_2013){ Date.new(2013, 12, 31) }
    let(:jan_31_2014){ Date.new(2014,  1, 31) }
    let(:apr_1_2014 ){ Date.new(2014,  4,  1) }

    let!(:jan_31_2012_member){ Member.make!(created_at: jan_31_2012, amount_paid: 130) }
    let!(:mar_31_2012_member){ Member.make!(created_at: mar_31_2012, amount_paid: 70) }
    let!(:dec_31_2012_member){ Member.make!(created_at: dec_31_2012, amount_paid: 70) }
    let!(:jan_31_2013_member){ Member.make!(created_at: jan_31_2013, amount_paid: 130) }
    let!(:mar_31_2013_member){ Member.make!(created_at: mar_31_2013, amount_paid: 0) }
    let!(:dec_31_2013_member){ Member.make!(created_at: dec_31_2013, amount_paid: 130) }
    let!(:jan_31_2014_member){ Member.make!(created_at: jan_31_2014, amount_paid: 130) }

    describe "#funds_raised(year)" do
      it "sums funds collected from jan 1 - dec 31 for the specified year" do
        Timecop.freeze(mar_31_2012) do
          expect(Member.funds_raised).to eq 130 + 70 + 70
        end
      end
    end
=begin
    describe "#current" do
      it "returns members who are paid up for the current MUBC year" do
        Timecop.freeze(jan_31_2012) do
          Member.current.should == [jan_31_2012_member]
        end

        Timecop.freeze(mar_31_2012) do
          Member.current.should == [jan_31_2012_member, mar_31_2012_member]
        end

        Timecop.freeze(dec_31_2012) do
          Member.current.should == [jan_31_2012_member, mar_31_2012_member, dec_31_2012_member]
        end

        Timecop.freeze(jan_31_2013) do
          Member.current.should == [jan_31_2012_member, mar_31_2012_member, dec_31_2012_member, jan_31_2013_member]
        end

        Timecop.freeze(mar_31_2013) do
          Member.current.should == [jan_31_2012_member, mar_31_2012_member, dec_31_2012_member, jan_31_2013_member, mar_31_2013_member]
        end

        Timecop.freeze(dec_31_2013) do
          Member.current.should == [jan_31_2013_member, mar_31_2013_member, dec_31_2013_member]
        end

        Timecop.freeze(apr_1_2014) do
          Member.current.should == [jan_31_2014_member]
        end
      end
    end
=end
  end
end
