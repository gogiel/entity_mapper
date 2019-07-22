# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/pg/all/pg.rbi
#
# pg-1.1.4
module PG
  def self.connect(*args); end
  def self.init_openssl(arg0, arg1); end
  def self.init_ssl(arg0); end
  def self.is_threadsafe?; end
  def self.isthreadsafe; end
  def self.library_version; end
  def self.threadsafe?; end
  def self.version_string(include_buildnum = nil); end
end
class PG::Connection
  def async_describe_portal(arg0); end
  def async_describe_prepared(arg0); end
  def async_exec(*arg0); end
  def async_exec_params(*arg0); end
  def async_exec_prepared(*arg0); end
  def async_prepare(*arg0); end
  def async_query(*arg0); end
  def backend_pid; end
  def block(*arg0); end
  def cancel; end
  def client_encoding=(arg0); end
  def close; end
  def conndefaults; end
  def conndefaults_hash; end
  def connect_poll; end
  def connection_needs_password; end
  def connection_used_password; end
  def conninfo; end
  def conninfo_hash; end
  def consume_input; end
  def copy_data(sql, coder = nil); end
  def db; end
  def decoder_for_get_copy_data; end
  def decoder_for_get_copy_data=(arg0); end
  def describe_portal(arg0); end
  def describe_prepared(arg0); end
  def discard_results; end
  def encoder_for_put_copy_data; end
  def encoder_for_put_copy_data=(arg0); end
  def encrypt_password(*arg0); end
  def error_message; end
  def escape(arg0); end
  def escape_bytea(arg0); end
  def escape_identifier(arg0); end
  def escape_literal(arg0); end
  def escape_string(arg0); end
  def exec(*arg0); end
  def exec_params(*arg0); end
  def exec_prepared(*arg0); end
  def external_encoding; end
  def finish; end
  def finished?; end
  def flush; end
  def get_client_encoding; end
  def get_copy_data(*arg0); end
  def get_last_result; end
  def get_result; end
  def guess_result_memsize=(arg0); end
  def host; end
  def initialize(*arg0); end
  def internal_encoding; end
  def internal_encoding=(arg0); end
  def is_busy; end
  def isnonblocking; end
  def lo_close(arg0); end
  def lo_creat(*arg0); end
  def lo_create(arg0); end
  def lo_export(arg0, arg1); end
  def lo_import(arg0); end
  def lo_lseek(arg0, arg1, arg2); end
  def lo_open(*arg0); end
  def lo_read(arg0, arg1); end
  def lo_seek(arg0, arg1, arg2); end
  def lo_tell(arg0); end
  def lo_truncate(arg0, arg1); end
  def lo_unlink(arg0); end
  def lo_write(arg0, arg1); end
  def loclose(arg0); end
  def locreat(*arg0); end
  def locreate(arg0); end
  def loexport(arg0, arg1); end
  def loimport(arg0); end
  def lolseek(arg0, arg1, arg2); end
  def loopen(*arg0); end
  def loread(arg0, arg1); end
  def loseek(arg0, arg1, arg2); end
  def lotell(arg0); end
  def lotruncate(arg0, arg1); end
  def lounlink(arg0); end
  def lowrite(arg0, arg1); end
  def make_empty_pgresult(arg0); end
  def nonblocking?; end
  def notifies; end
  def notifies_wait(*arg0); end
  def options; end
  def parameter_status(arg0); end
  def pass; end
  def port; end
  def prepare(*arg0); end
  def protocol_version; end
  def put_copy_data(*arg0); end
  def put_copy_end(*arg0); end
  def query(*arg0); end
  def quote_ident(arg0); end
  def reset; end
  def reset_poll; end
  def reset_start; end
  def self.async_api=(enable); end
  def self.conndefaults; end
  def self.conndefaults_hash; end
  def self.connect(*arg0); end
  def self.connect_start(*arg0); end
  def self.encrypt_password(arg0, arg1); end
  def self.escape(arg0); end
  def self.escape_bytea(arg0); end
  def self.escape_string(arg0); end
  def self.isthreadsafe; end
  def self.open(*arg0); end
  def self.parse_connect_args(*args); end
  def self.ping(*arg0); end
  def self.quote_connstr(value); end
  def self.quote_ident(arg0); end
  def self.setdb(*arg0); end
  def self.setdblogin(*arg0); end
  def self.unescape_bytea(arg0); end
  def send_describe_portal(arg0); end
  def send_describe_prepared(arg0); end
  def send_prepare(*arg0); end
  def send_query(*arg0); end
  def send_query_params(*arg0); end
  def send_query_prepared(*arg0); end
  def server_version; end
  def set_client_encoding(arg0); end
  def set_default_encoding; end
  def set_error_verbosity(arg0); end
  def set_notice_processor; end
  def set_notice_receiver; end
  def set_single_row_mode; end
  def setnonblocking(arg0); end
  def socket; end
  def socket_io; end
  def ssl_attribute(arg0); end
  def ssl_attribute_names; end
  def ssl_attributes; end
  def ssl_in_use?; end
  def status; end
  def sync_describe_portal(arg0); end
  def sync_describe_prepared(arg0); end
  def sync_exec(*arg0); end
  def sync_exec_params(*arg0); end
  def sync_exec_prepared(*arg0); end
  def sync_prepare(*arg0); end
  def trace(arg0); end
  def transaction; end
  def transaction_status; end
  def tty; end
  def type_map_for_queries; end
  def type_map_for_queries=(arg0); end
  def type_map_for_results; end
  def type_map_for_results=(arg0); end
  def unescape_bytea(arg0); end
  def untrace; end
  def user; end
  def wait_for_notify(*arg0); end
end
class PG::Result
  def [](arg0); end
  def autoclear?; end
  def check; end
  def check_result; end
  def clear; end
  def cleared?; end
  def cmd_status; end
  def cmd_tuples; end
  def cmdtuples; end
  def column_values(arg0); end
  def each; end
  def each_row; end
  def error_field(arg0); end
  def error_message; end
  def fformat(arg0); end
  def field_values(arg0); end
  def fields; end
  def fmod(arg0); end
  def fname(arg0); end
  def fnumber(arg0); end
  def fsize(arg0); end
  def ftable(arg0); end
  def ftablecol(arg0); end
  def ftype(arg0); end
  def getisnull(arg0, arg1); end
  def getlength(arg0, arg1); end
  def getvalue(arg0, arg1); end
  def inspect; end
  def map_types!(type_map); end
  def nfields; end
  def nparams; end
  def ntuples; end
  def num_fields; end
  def num_tuples; end
  def oid_value; end
  def paramtype(arg0); end
  def res_status(arg0); end
  def result_error_field(arg0); end
  def result_error_message; end
  def result_status; end
  def stream_each; end
  def stream_each_row; end
  def stream_each_tuple; end
  def tuple(arg0); end
  def tuple_values(arg0); end
  def type_map; end
  def type_map=(arg0); end
  def values; end
end
class PG::Error < StandardError
  def connection; end
  def error; end
  def result; end
end
module PG::TypeMap::DefaultTypeMappable
  def default_type_map; end
  def default_type_map=(arg0); end
  def with_default_type_map(arg0); end
end
class PG::TypeMapByClass < PG::TypeMap
  def [](arg0); end
  def []=(arg0, arg1); end
  def coders; end
end
class PG::TypeMapByColumn < PG::TypeMap
  def coders; end
  def initialize(arg0); end
  def inspect; end
  def oids; end
end
class PG::TypeMapByMriType < PG::TypeMap
  def [](arg0); end
  def []=(arg0, arg1); end
  def coders; end
end
class PG::TypeMapByOid < PG::TypeMap
  def add_coder(arg0); end
  def build_column_map(arg0); end
  def coders; end
  def max_rows_for_online_lookup; end
  def max_rows_for_online_lookup=(arg0); end
  def rm_coder(arg0, arg1); end
end
class PG::TypeMapInRuby < PG::TypeMap
  def typecast_copy_get(arg0, arg1, arg2, arg3); end
  def typecast_query_param(arg0, arg1); end
  def typecast_result_value(arg0, arg1, arg2); end
end
class PG::Coder
  def ==(v); end
  def decode(*arg0); end
  def dup; end
  def encode(*arg0); end
  def flags; end
  def flags=(arg0); end
  def format; end
  def format=(arg0); end
  def initialize(params = nil); end
  def inspect; end
  def marshal_dump; end
  def marshal_load(str); end
  def name; end
  def name=(arg0); end
  def oid; end
  def oid=(arg0); end
  def to_h; end
end
class PG::CompositeCoder < PG::Coder
  def delimiter; end
  def delimiter=(arg0); end
  def elements_type; end
  def elements_type=(arg0); end
  def inspect; end
  def needs_quotation=(arg0); end
  def needs_quotation?; end
  def to_h; end
end
class IPAddr
  def &(other); end
  def <<(num); end
  def <=>(other); end
  def ==(other); end
  def ===(other); end
  def >>(num); end
  def _ipv4_compat?; end
  def _reverse; end
  def _to_string(addr); end
  def addr_mask(addr); end
  def coerce_other(other); end
  def eql?(other); end
  def family; end
  def hash; end
  def hton; end
  def in6_addr(left); end
  def in_addr(addr); end
  def include?(other); end
  def initialize(addr = nil, family = nil); end
  def inspect; end
  def ip6_arpa; end
  def ip6_int; end
  def ipv4?; end
  def ipv4_compat; end
  def ipv4_compat?; end
  def ipv4_mapped; end
  def ipv4_mapped?; end
  def ipv6?; end
  def link_local?; end
  def loopback?; end
  def mask!(mask); end
  def mask(prefixlen); end
  def native; end
  def prefix; end
  def prefix=(prefix); end
  def private?; end
  def reverse; end
  def self.new_ntoh(addr); end
  def self.ntop(addr); end
  def set(addr, *family); end
  def succ; end
  def to_i; end
  def to_range; end
  def to_s; end
  def to_string; end
  def |(other); end
  def ~; end
  include Comparable
end
class IPAddr::Error < ArgumentError
end
class IPAddr::InvalidAddressError < IPAddr::Error
end
class IPAddr::AddressFamilyError < IPAddr::Error
end
class IPAddr::InvalidPrefixError < IPAddr::InvalidAddressError
end
class PG::CopyCoder < PG::Coder
  def delimiter; end
  def delimiter=(arg0); end
  def null_string; end
  def null_string=(arg0); end
  def to_h; end
  def type_map; end
  def type_map=(arg0); end
end
class PG::Tuple
  def [](arg0); end
  def each; end
  def each_key(&block); end
  def each_value; end
  def fetch(*arg0); end
  def field_map; end
  def field_names; end
  def has_key?(key); end
  def index(arg0); end
  def inspect; end
  def key?(key); end
  def keys; end
  def length; end
  def marshal_dump; end
  def marshal_load(arg0); end
  def size; end
  def values; end
end
module PG::Constants
end
module PG::Coder::BinaryFormatting
  def initialize(params = nil); end
end
module PG::BinaryDecoder
end
class PG::BinaryDecoder::TimestampUtc < PG::BinaryDecoder::Timestamp
  def initialize(params = nil); end
end
class PG::BinaryDecoder::TimestampUtcToLocal < PG::BinaryDecoder::Timestamp
  def initialize(params = nil); end
end
class PG::BinaryDecoder::TimestampLocal < PG::BinaryDecoder::Timestamp
  def initialize(params = nil); end
end
module PG::TextEncoder
end
class PG::TextEncoder::Date < PG::SimpleEncoder
  def encode(value); end
end
class PG::TextEncoder::TimestampWithoutTimeZone < PG::SimpleEncoder
  def encode(value); end
end
class PG::TextEncoder::TimestampUtc < PG::SimpleEncoder
  def encode(value); end
end
class PG::TextEncoder::TimestampWithTimeZone < PG::SimpleEncoder
  def encode(value); end
end
class PG::TextEncoder::Numeric < PG::SimpleEncoder
  def encode(value); end
end
class PG::TextEncoder::JSON < PG::SimpleEncoder
  def encode(value); end
end
class PG::TextEncoder::Inet < PG::SimpleEncoder
  def encode(value); end
end
module PG::TextDecoder
end
class PG::TextDecoder::Date < PG::SimpleDecoder
  def decode(string, tuple = nil, field = nil); end
end
class PG::TextDecoder::JSON < PG::SimpleDecoder
  def decode(string, tuple = nil, field = nil); end
end
class PG::TextDecoder::TimestampUtc < PG::TextDecoder::Timestamp
  def initialize(params = nil); end
end
class PG::TextDecoder::TimestampUtcToLocal < PG::TextDecoder::Timestamp
  def initialize(params = nil); end
end
class PG::TextDecoder::TimestampLocal < PG::TextDecoder::Timestamp
  def initialize(params = nil); end
end
module PG::BasicTypeRegistry
  def build_coder_maps(connection); end
  def check_format_and_direction(format, direction); end
  def self.alias_type(format, new, old); end
  def self.register_type(format, name, encoder_class, decoder_class); end
  def supports_ranges?(connection); end
end
class PG::BasicTypeRegistry::CoderMap
  def coder_by_name(name); end
  def coder_by_oid(oid); end
  def coders; end
  def coders_by_name; end
  def coders_by_oid; end
  def initialize(result, coders_by_name, format, arraycoder); end
  def typenames_by_oid; end
end
class PG::BasicTypeMapForResults < PG::TypeMapByOid
  def initialize(connection); end
  include PG::BasicTypeRegistry
end
class PG::BasicTypeMapForResults::WarningTypeMap < PG::TypeMapInRuby
  def initialize(typenames); end
  def typecast_result_value(result, _tuple, field); end
end
class PG::BasicTypeMapBasedOnResult < PG::TypeMapByOid
  def initialize(connection); end
  include PG::BasicTypeRegistry
end
class PG::BasicTypeMapForQueries < PG::TypeMapByClass
  def array_encoders_by_klass; end
  def coder_by_name(format, direction, name); end
  def get_array_type(value); end
  def initialize(connection); end
  def populate_encoder_list; end
  include PG::BasicTypeRegistry
end
class PG::NotAllCopyDataRetrieved < PG::Error
end