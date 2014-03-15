require 'resolv'

class RandStat
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  belongs_to :gen

  field :num,      type: Integer
  field :ip,       type: String
  field :j_time,   type: Time
  
  validates :num, presence: true
  validates :num, inclusion: { in: (0..9), message: "can only be from 0 to 9" }
  validate :valid_ip

  IPV4 = Resolv::IPv4::Regex
  IPV6 = Resolv::IPv6::Regex

  def for_api
    {
      num: num,
      created_at: created_at,
      id: id
    }
  end

private
  
  def valid_ip
    errors.add(:ip, "invalid") unless (ip =~ IPV4 || ip =~ IPV6)
  end
end