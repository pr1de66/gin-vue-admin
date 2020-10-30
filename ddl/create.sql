create table sys_authorities
(
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	authority_id varchar(90) not null
		constraint sys_authorities_pkey
			primary key,
	authority_name varchar(500),
	parent_id varchar(500)
);

alter table sys_authorities owner to putong;

create table sys_base_menus
(
	id bigserial not null
		constraint sys_base_menus_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	menu_level bigint,
	parent_id varchar(500),
	path varchar(500),
	name varchar(500),
	hidden boolean,
	component varchar(500),
	sort bigint,
	keep_alive boolean,
	default_menu boolean,
	title varchar(500),
	icon varchar(500)
);

alter table sys_base_menus owner to putong;

create index idx_sys_base_menus_deleted_at
	on sys_base_menus (deleted_at);

create table sys_authority_menus
(
	sys_base_menu_id bigint not null,
	sys_authority_authority_id varchar(90) not null,
	constraint sys_authority_menus_pkey
		primary key (sys_base_menu_id, sys_authority_authority_id)
);

alter table sys_authority_menus owner to putong;

create table sys_data_authority_id
(
	sys_authority_authority_id varchar(90) not null,
	data_authority_id_authority_id varchar(90) not null,
	constraint sys_data_authority_id_pkey
		primary key (sys_authority_authority_id, data_authority_id_authority_id)
);

alter table sys_data_authority_id owner to putong;

create table sys_apis
(
	id bigserial not null
		constraint sys_apis_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	path varchar(500),
	description varchar(500),
	api_group varchar(500),
	method varchar(500) default 'POST'::text
);

alter table sys_apis owner to putong;

create index idx_sys_apis_deleted_at
	on sys_apis (deleted_at);

create table sys_base_menu_parameters
(
	id bigserial not null
		constraint sys_base_menu_parameters_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	sys_base_menu_id bigint,
	type varchar(500),
	key varchar(500),
	value varchar(500)
);

alter table sys_base_menu_parameters owner to putong;

create index idx_sys_base_menu_parameters_deleted_at
	on sys_base_menu_parameters (deleted_at);

create table jwt_blacklists
(
	id bigserial not null
		constraint jwt_blacklists_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	jwt varchar(500)
);

alter table jwt_blacklists owner to putong;

create index idx_jwt_blacklists_deleted_at
	on jwt_blacklists (deleted_at);

create table sys_workflows
(
	id bigserial not null
		constraint sys_workflows_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	workflow_nick_name varchar(500),
	workflow_name varchar(500),
	workflow_description varchar(500)
);

alter table sys_workflows owner to putong;

create index idx_sys_workflows_deleted_at
	on sys_workflows (deleted_at);

create table sys_workflow_step_infos
(
	id bigserial not null
		constraint sys_workflow_step_infos_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	sys_workflow_id bigint,
	is_start boolean,
	step_name varchar(500),
	step_no numeric,
	step_authority_id varchar(500),
	is_end boolean
);

alter table sys_workflow_step_infos owner to putong;

create index idx_sys_workflow_step_infos_deleted_at
	on sys_workflow_step_infos (deleted_at);

create table sys_dictionaries
(
	id bigserial not null
		constraint sys_dictionaries_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	name varchar(500),
	type varchar(500),
	status boolean,
	"desc" varchar(500)
);

alter table sys_dictionaries owner to putong;

create index idx_sys_dictionaries_deleted_at
	on sys_dictionaries (deleted_at);

create table sys_dictionary_details
(
	id bigserial not null
		constraint sys_dictionary_details_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	label varchar(500),
	value bigint,
	status boolean,
	sort bigint,
	sys_dictionary_id bigint
);

alter table sys_dictionary_details owner to putong;

create index idx_sys_dictionary_details_deleted_at
	on sys_dictionary_details (deleted_at);

create table exa_file_upload_and_downloads
(
	id bigserial not null
		constraint exa_file_upload_and_downloads_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	name varchar(500),
	url varchar(500),
	tag varchar(500),
	key varchar(500)
);

alter table exa_file_upload_and_downloads owner to putong;

create index idx_exa_file_upload_and_downloads_deleted_at
	on exa_file_upload_and_downloads (deleted_at);

create table exa_files
(
	id bigserial not null
		constraint exa_files_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	file_name varchar(500),
	file_md5 varchar(500),
	file_path varchar(500),
	chunk_total bigint,
	is_finish boolean
);

alter table exa_files owner to putong;

create index idx_exa_files_deleted_at
	on exa_files (deleted_at);

create table exa_file_chunks
(
	id bigserial not null
		constraint exa_file_chunks_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	exa_file_id bigint,
	file_chunk_number bigint,
	file_chunk_path varchar(500)
);

alter table exa_file_chunks owner to putong;

create index idx_exa_file_chunks_deleted_at
	on exa_file_chunks (deleted_at);

create table exa_simple_uploaders
(
	chunk_number varchar(500),
	current_chunk_size varchar(500),
	current_chunk_path varchar(500),
	total_size varchar(500),
	identifier varchar(500),
	filename varchar(500),
	total_chunks varchar(500),
	is_done boolean,
	file_path varchar(500)
);

alter table exa_simple_uploaders owner to putong;

create table exa_customers
(
	id bigserial not null
		constraint exa_customers_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	customer_name varchar(500),
	customer_phone_data varchar(500),
	sys_user_id bigint,
	sys_user_authority_id varchar(500)
);

alter table exa_customers owner to putong;

create index idx_exa_customers_deleted_at
	on exa_customers (deleted_at);

create table sys_operation_records
(
	id bigserial not null
		constraint sys_operation_records_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	ip varchar(50),
	method varchar(100),
	path varchar(100),
	status bigint,
	latency bigint,
	agent varchar(200),
	error_message varchar(500),
	body varchar(500),
	resp text,
	user_id bigint
);

alter table sys_operation_records owner to putong;

create index idx_sys_operation_records_deleted_at
	on sys_operation_records (deleted_at);

create table sys_users
(
	id bigserial not null
		constraint sys_users_pkey
			primary key,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	uuid varchar(500),
	username varchar(500),
	password varchar(500),
	nick_name varchar(500) default '系统用户'::text,
	header_img varchar(500) default 'http://qmplusimg.henrongyi.top/head.png'::text,
	authority_id varchar(90) default '888'::character varying
);

alter table sys_users owner to putong;

create index idx_sys_users_deleted_at
	on sys_users (deleted_at);

CREATE OR REPLACE VIEW authority_menu AS select b.id,b.created_at,b.updated_at,b.deleted_at, b.menu_level,b.parent_id,b.path,b.name,b.hidden,b.component, b.title,b.icon,b.sort,a.sys_authority_authority_id AS authority_id,a.sys_base_menu_id AS menu_id,b.keep_alive,b.default_menu from sys_authority_menus a join sys_base_menus b on a.sys_base_menu_id = b.id;
