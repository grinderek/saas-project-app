class Artifact < ActiveRecord::Base

  before_save :upload_to_s3
  attr_accessor :upload
  belongs_to :project

  MAX_FILESIZE = 10.megabytes
  validates_presence_of :name, :upload
  validates_uniqueness_of :name

  validate :uploaded_file_size

  private

  def upload_to_s3
    s3 = Aws::S3::Resource.new
    obj = s3.bucket(ENV['S3_BUCKET']).object("#{Apartment::Tenant.current}/#{upload.original_filename}")
    obj.upload_file(upload.path, acl:'public-read')
    self.key = obj.public_url
  end

  def uploaded_file_size
    if upload
      errors.add(:upload, "File size must be less than #{self.class::MAX_FILESIZE}") unless upload.size <= self.class::MAX_FILESIZE
    end
  end
end