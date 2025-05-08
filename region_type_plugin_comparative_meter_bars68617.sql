prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.1.7'
,p_default_workspace_id=>7698810536136159
,p_default_application_id=>100
,p_default_id_offset=>0
,p_default_owner=>'WKSP_DEV'
);
end;
/
 
prompt APPLICATION 100 - MyApp
--
-- Application Export:
--   Application:     100
--   Name:            MyApp
--   Date and Time:   20:31 Thursday May 8, 2025
--   Exported By:     DEV
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 12349959918101827
--   Manifest End
--   Version:         24.1.7
--   Instance ID:     7698671066064501
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/region_type/comparative_meter_bars68617
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(12349959918101827)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COMPARATIVE_METER_BARS68617'
,p_display_name=>'Comaparative Meter Bars'
,p_javascript_file_urls=>'#PLUGIN_FILES#plugin_index#MIN#.js'
,p_css_file_urls=>'#PLUGIN_FILES#comparative_meter_bars_plugin#MIN#.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- Procedure to generate and loop through meter bars',
'procedure generate_meter_bars (',
'    p_region    in      apex_plugin.t_region,',
'    p_html      out     clob',
') is',
'    l_context apex_exec.t_context;',
'    l_record_id varchar2(255);',
'    l_record_name varchar2(255);',
'    l_record_value number;',
'    l_tick_value number;',
'    l_max_value number;',
'    l_color varchar2(30);',
'    l_unit varchar2(30);',
'    l_percentage number;',
'    l_tick_position number;',
'    l_link varchar2(255);',
'    l_format varchar2(30);',
'    ',
'    l_record_id_col_no     pls_integer;',
'    l_record_name_col_no   pls_integer;',
'    l_record_value_col_no  pls_integer;',
'    l_tick_value_col_no    pls_integer;',
'    l_max_value_col_no     pls_integer;',
'    l_color_col_no         pls_integer;',
'    l_unit_col_no          pls_integer;',
'    l_link_col_no          pls_integer;',
'    l_format_col_no        pls_integer;',
'',
'begin',
'    l_context        := apex_exec.open_query_context(',
'        p_max_rows   => p_region.fetched_rows',
'    );',
'    -- Add subtitle once, before looping through rows',
'    p_html := p_html || ''<div class="region-subtitle">'' || apex_escape.html(p_region.attributes.get_varchar2(''region_subtitle'')) || ''</div>'';',
'    ',
'    -- Set column positions',
'    l_record_id_col_no   := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2(''record_id''));',
'    l_record_name_col_no := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2(''record_name''));',
'    l_record_value_col_no := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2(''record_value''));',
'    l_tick_value_col_no   := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2(''tick_value''));',
'    l_max_value_col_no    := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2(''max_value''));',
'    l_color_col_no        := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2(''color''));',
'    l_unit_col_no         := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2(''unit''));',
'    l_link_col_no         := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2(''link''));',
'    l_format_col_no       := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2(''format''));',
'',
'',
'    -- Loop through the rows in the provided column value list',
'    while apex_exec.next_row(p_context => l_context) loop',
'        -- Fetch values dynamically using the column mappings',
'        l_record_id       := apex_escape.html(apex_exec.get_varchar2(l_context, l_record_id_col_no));',
'        l_record_name     := apex_escape.html(apex_exec.get_varchar2(l_context, l_record_name_col_no));',
'        l_record_value    := to_number(apex_exec.get_number(l_context, l_record_value_col_no));',
'        l_tick_value      := to_number(apex_exec.get_number(l_context, l_tick_value_col_no));',
'        l_max_value       := to_number(apex_exec.get_number(l_context, l_max_value_col_no));',
'        l_color           := apex_escape.html(apex_exec.get_varchar2(l_context, l_color_col_no));',
'        l_unit            := apex_escape.html(apex_exec.get_varchar2(l_context, l_unit_col_no));',
'        l_link            := apex_escape.html(apex_exec.get_varchar2(l_context, l_link_col_no));',
'        l_format          := apex_escape.html(apex_exec.get_varchar2(l_context, l_format_col_no));',
'',
'        -- Calculate percentages',
'        l_percentage      := round((l_record_value / l_max_value) * 100);',
'        l_tick_position   := round((l_tick_value / l_max_value) * 100);',
'',
'        -- Append the meter bar HTML',
'        p_html := p_html || ''',
'            <div class="meter-container">',
'                <div class="meter-header">',
'                    <a href="'' || l_link || ''" class="record-name">'' || l_record_name || ''</a>',
'                    <span class="value-text">'' || to_char(l_record_value, l_format) || '' '' || l_unit || ''</span>',
'                </div>',
'                <div class="meter-bar-container">',
'                    <div class="meter-bar" style="width:'' || l_percentage || ''%; background-color:'' || l_color || '';"></div>',
'                    <div class="meter-tick" style="left:'' || l_tick_position || ''%;"></div>',
'                </div>',
'            </div>',
'        '';',
'    end loop;',
'',
'    apex_exec.close(l_context);',
'end generate_meter_bars;',
'',
'',
'-- render procedure',
'procedure render (',
'    p_region              in apex_plugin.t_region,',
'    p_plugin              in apex_plugin.t_plugin,',
'    p_param               in apex_plugin.t_region_render_param,',
'    p_result              in out apex_plugin.t_region_render_result',
') is',
'    l_region_static_id varchar2(255);',
'    l_html clob := ''''; -- Initialize l_html to an empty string',
'begin',
'',
'    l_region_static_id := p_region.static_id;',
'    sys.htp.p(''<div id="'' || l_region_static_id || ''_body">'');',
'',
'    apex_javascript.add_onload_code(',
'        ''window.comparative_meter_bars.init(`'' || l_region_static_id || ''`,`'' || apex_plugin.get_ajax_identifier || ''`)'' ',
'    );',
'',
'    -- Call the generate_meter_bars function to generate HTML',
'    generate_meter_bars(',
'        p_region   => p_region,',
'        p_html              => l_html',
'    );',
'',
'    -- Output the accumulated HTML',
'    sys.htp.p(l_html);',
'    sys.htp.p(''</div>'');',
'end render;',
'',
'-- ajax_region procedure',
'procedure ajax_region (',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_region in            apex_plugin.t_region,',
'    p_param  in            apex_plugin.t_region_ajax_param,',
'    p_result in out nocopy apex_plugin.t_region_ajax_result )',
'as',
'    l_context apex_exec.t_context;',
'    l_html clob := ''''; -- Initialize l_html to an empty string',
'begin ',
'',
'    -- Call the generate_meter_bars function to generate HTML',
'    generate_meter_bars(',
'        p_region        => p_region,',
'        p_html          => l_html',
'    );',
'',
'    apex_json.open_object;',
'    apex_json.write(''heading'', p_region.title);',
'    apex_json.write(''html'', l_html);',
'    apex_json.close_object;',
'    apex_json.close_all;',
'end ajax_region;',
''))
,p_api_version=>3
,p_render_function=>'render'
,p_ajax_function=>'ajax_region'
,p_standard_attributes=>'SOURCE_LOCATION:AJAX_ITEMS_TO_SUBMIT:COLUMNS'
,p_substitute_attributes=>true
,p_version_scn=>39662888426155
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'2.0'
,p_files_version=>117
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(12373693246166573)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_title=>'General'
,p_display_sequence=>10
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(24685520570106587)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_title=>'Column Mapping'
,p_display_sequence=>20
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(12350543032101837)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'region_subtitle'
,p_prompt=>'Region Subtitle'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(12373693246166573)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(12363798836149989)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'record_id'
,p_prompt=>'Record Id'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(24685520570106587)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(12364368302153365)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'record_name'
,p_prompt=>'Record Name'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(24685520570106587)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(12364945388155370)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'record_value'
,p_prompt=>'Record Value'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(24685520570106587)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(12365560524158453)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'max_value'
,p_prompt=>'Max Value'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2:NUMBER'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(24685520570106587)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(12366122791160574)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'tick_value'
,p_prompt=>'Tick Value'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(24685520570106587)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(12368607812167588)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_static_id=>'color'
,p_prompt=>'Color'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(24685520570106587)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(12369380667172096)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'unit'
,p_prompt=>'Unit'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(24685520570106587)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(12369920604173065)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_static_id=>'link'
,p_prompt=>'Link'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(24685520570106587)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(12370526335174520)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_static_id=>'format'
,p_prompt=>'Format'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(24685520570106587)
);
wwv_flow_imp_shared.create_plugin_std_attribute(
 p_id=>wwv_flow_imp.id(12351574670101844)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_name=>'SOURCE_LOCATION'
,p_depending_on_has_to_exist=>true
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<pre>',
'select ',
'  region_id,',
'  region_name,',
'  actual_value,',
'  tick,',
'  max_value,',
'  color,',
'  unit,',
'  link,',
'  format',
'from (',
'  select 1 region_id, ''Rabat'' region_name, ',
'         48752 actual_value, 51234 tick, 100000 max_value, ',
'         ''#306140'' color, ''kWh'' unit, ',
'         ''javascript:void(window.open(''''https://en.wikipedia.org/wiki/Rabat'''', ''''_blank''''))'' link, ',
'         ''999,999,999'' format',
'  from dual',
'  union all',
'  select 2, ''Casablanca'', ',
'         67890, 60213, 100000, ',
'         ''#FF5733'', ''kWh'', ',
'         ''javascript:void(window.open(''''https://en.wikipedia.org/wiki/Casablanca'''', ''''_blank''''))'', ',
'         ''999,999,999''',
'  from dual',
'  union all',
'  select 3, ''Marrakech'', ',
'         53412, 45901, 100000, ',
'         ''#1E90FF'', ''kWh'', ',
'         ''javascript:void(window.open(''''https://en.wikipedia.org/wiki/Marrakech'''', ''''_blank''''))'',',
'         ''999,999,999''',
'  from dual',
'  union all',
'  select 4, ''Fes'', ',
'         42876, 39564, 100000, ',
'         ''#32CD32'', ''kWh'', ',
'         ''javascript:void(window.open(''''https://en.wikipedia.org/wiki/Fes'''', ''''_blank''''))'',',
'         ''999,999,999''',
'  from dual',
'  union all',
'  select 5, ''Tangier'', ',
'         59234, 48820, 100000, ',
'         ''#FFD700'', ''kWh'', ',
'         ''javascript:void(window.open(''''https://en.wikipedia.org/wiki/Tangier'''', ''''_blank''''))'',',
'         ''999,999,999''',
'  from dual',
'  union all',
'  select 6, ''Agadir'', ',
'         45321, 40231, 100000, ',
'         ''#8A2BE2'', ''kWh'', ',
'         ''javascript:void(window.open(''''https://en.wikipedia.org/wiki/Agadir'''', ''''_blank''''))'',',
'         ''999,999,999''',
'  from dual',
')',
'</pre>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'  In this field, you should enter the SQL query used to fetch the data you want to visualize.',
'</p>'))
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E6D657465722D636F6E7461696E6572207B0A202020206D617267696E2D746F703A20313570783B0A202020206D617267696E2D626F74746F6D3A20313070783B0A7D0A2E7265636F72642D6E616D657B0A20202020666F6E742D73697A653A20736D61';
wwv_flow_imp.g_varchar2_table(2) := '6C6C3B0A7D0A2E6D657465722D686561646572207B0A20202020646973706C61793A20666C65783B0A202020206A7573746966792D636F6E74656E743A2073706163652D6265747765656E3B0A202020206D617267696E2D626F74746F6D3A203570783B';
wwv_flow_imp.g_varchar2_table(3) := '0A7D0A2E76616C75652D74657874207B0A20202020746578742D616C69676E3A2072696768743B0A20202020636F6C6F723A20726762283130322C203130312C203939293B0A20202020666F6E742D73697A653A20736D616C6C3B0A7D0A2E6D65746572';
wwv_flow_imp.g_varchar2_table(4) := '2D6261722D636F6E7461696E6572207B0A202020206261636B67726F756E642D636F6C6F723A20236539656365663B0A20202020626F726465722D7261646975733A203170783B0A202020206865696768743A20313270783B0A202020206F766572666C';
wwv_flow_imp.g_varchar2_table(5) := '6F773A2068696464656E3B0A7D0A2E6D657465722D626172207B0A202020206865696768743A20313030253B0A20202020626F726465722D7261646975733A203170783B0A7D0A2E6D657465722D6261722D636F6E7461696E6572207B0A202020206261';
wwv_flow_imp.g_varchar2_table(6) := '636B67726F756E642D636F6C6F723A205247422032313920323136203231353B0A20202020626F726465722D7261646975733A203170783B0A202020206865696768743A20313070783B0A202020206F766572666C6F773A2068696464656E3B0A202020';
wwv_flow_imp.g_varchar2_table(7) := '206D617267696E2D746F703A203870783B0A20202020706F736974696F6E3A2072656C61746976653B0A7D0A2E6D657465722D7469636B207B0A20202020706F736974696F6E3A206162736F6C7574653B0A202020206865696768743A20313030253B0A';
wwv_flow_imp.g_varchar2_table(8) := '2020202077696474683A203270783B0A20202020746F703A20303B0A202020206261636B67726F756E642D636F6C6F723A7267622834332C2034332C203433293B0A7D0A2E726567696F6E2D7469746C657B0A20202020666F6E742D73697A653A203230';
wwv_flow_imp.g_varchar2_table(9) := '70783B0A20202020666F6E742D7765696768743A203530303B0A7D0A2E726567696F6E2D7375627469746C657B0A20202020666F6E742D73697A653A20313470783B0A20202020636F6C6F723A207267622838332C2038332C203833293B0A7D';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(12351906017101847)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_file_name=>'comparative_meter_bars_plugin.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '77696E646F772E636F6D70617261746976655F6D657465725F62617273203D2077696E646F772E636F6D70617261746976655F6D657465725F62617273207C7C207B7D3B0A0A77696E646F772E636F6D70617261746976655F6D657465725F626172732E';
wwv_flow_imp.g_varchar2_table(2) := '696E6974203D202870526567696F6E49642C2070416A6178496429203D3E207B0A20202020617065782E64656275672E696E666F2827496E697469616C697A696E6720636F6D70617261746976655F6D657465725F6261727320666F7220726567696F6E';
wwv_flow_imp.g_varchar2_table(3) := '3A272C2070526567696F6E49642C2070416A61784964293B0A0A20202020617065782E726567696F6E2E6372656174652870526567696F6E49642C207B0A2020202020202020747970653A2022636F6D70617261746976655F6D657465725F6261727322';
wwv_flow_imp.g_varchar2_table(4) := '2C0A2020202020202020726566726573683A202829203D3E207B0A202020202020202020202020617065782E7365727665722E706C7567696E280A2020202020202020202020202020202070416A617849642C0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(5) := '7B7D2C0A202020202020202020202020202020207B0A202020202020202020202020202020202020202064617461547970653A20276A736F6E272C0A2020202020202020202020202020202020202020737563636573733A20286461746129203D3E207B';
wwv_flow_imp.g_varchar2_table(6) := '0A202020202020202020202020202020202020202020202020636F6E737420726567696F6E456C203D20646F63756D656E742E676574456C656D656E74427949642870526567696F6E4964293B0A20202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(7) := '2020617065782E64656275672E696E666F2822414A415820446174613A222C2064617461293B0A2020202020202020202020202020202020202020202020200A2020202020202020202020202020202020202020202020206966202821726567696F6E45';
wwv_flow_imp.g_varchar2_table(8) := '6C29207B0A20202020202020202020202020202020202020202020202020202020617065782E64656275672E7761726E2822526567696F6E20656C656D656E74206E6F7420666F756E643A222C2070526567696F6E4964293B0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(9) := '20202020202020202020202020202020202072657475726E3B0A2020202020202020202020202020202020202020202020207D0A0A202020202020202020202020202020202020202020202020636F6E737420626F6479456C203D20726567696F6E456C';
wwv_flow_imp.g_varchar2_table(10) := '2E717565727953656C6563746F7228272327202B2070526567696F6E4964202B20275F626F647927293B0A20202020202020202020202020202020202020200A20202020202020202020202020202020202020202020202069662028626F6479456C2920';
wwv_flow_imp.g_varchar2_table(11) := '7B0A20202020202020202020202020202020202020202020202020202020626F6479456C2E696E6E657248544D4C203D20646174612E68746D6C3B0A2020202020202020202020202020202020202020202020207D20656C7365207B0A20202020202020';
wwv_flow_imp.g_varchar2_table(12) := '202020202020202020202020202020202020202020617065782E64656275672E7761726E2822426F647920656C656D656E74206E6F7420666F756E643A222C2070526567696F6E4964202B20275F626F647927293B0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(13) := '202020202020202020207D0A0A202020202020202020202020202020202020202020202020636F6E73742068656164696E67456C203D20726567696F6E456C2E717565727953656C6563746F72286023247B70526567696F6E49647D5F68656164696E67';
wwv_flow_imp.g_varchar2_table(14) := '60293B0A2020202020202020202020202020202020202020202020200A202020202020202020202020202020202020202020202020696628646174612E68656164696E672026262068656164696E67456C20297B0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(15) := '2020202020202020202020202068656164696E67456C2E74657874436F6E74656E74203D20646174612E68656164696E673B0A2020202020202020202020202020202020202020202020207D656C7365207B0A2020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(16) := '2020202020202020202020617065782E64656275672E7761726E28227468652068656164696E67207761736E27742073656E742066726F6D206261636B656E64206F722048656164696E6720656C656D656E74206E6F7420666F756E6422293B0A202020';
wwv_flow_imp.g_varchar2_table(17) := '2020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020207D2C0A20202020202020202020202020202020202020206572726F723A20286A715848522C20746578745374617475732C206572726F725468';
wwv_flow_imp.g_varchar2_table(18) := '726F776E29203D3E207B0A202020202020202020202020202020202020202020202020617065782E64656275672E6572726F7228224572726F722072656672657368696E6720726567696F6E3A222C20746578745374617475732C206572726F72546872';
wwv_flow_imp.g_varchar2_table(19) := '6F776E293B0A20202020202020202020202020202020202020207D0A202020202020202020202020202020207D0A202020202020202020202020293B0A20202020202020207D0A202020207D293B0A7D3B0A';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(12352740469101849)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_file_name=>'plugin_index.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '77696E646F772E636F6D70617261746976655F6D657465725F626172733D77696E646F772E636F6D70617261746976655F6D657465725F626172737C7C7B7D2C77696E646F772E636F6D70617261746976655F6D657465725F626172732E696E69743D28';
wwv_flow_imp.g_varchar2_table(2) := '652C72293D3E7B617065782E64656275672E696E666F2822496E697469616C697A696E6720636F6D70617261746976655F6D657465725F6261727320666F7220726567696F6E3A222C652C72292C617065782E726567696F6E2E63726561746528652C7B';
wwv_flow_imp.g_varchar2_table(3) := '747970653A22636F6D70617261746976655F6D657465725F62617273222C726566726573683A28293D3E7B617065782E7365727665722E706C7567696E28722C7B7D2C7B64617461547970653A226A736F6E222C737563636573733A723D3E7B636F6E73';
wwv_flow_imp.g_varchar2_table(4) := '74206E3D646F63756D656E742E676574456C656D656E74427949642865293B696628617065782E64656275672E696E666F2822414A415820446174613A222C72292C216E2972657475726E20766F696420617065782E64656275672E7761726E28225265';
wwv_flow_imp.g_varchar2_table(5) := '67696F6E20656C656D656E74206E6F7420666F756E643A222C65293B636F6E737420613D6E2E717565727953656C6563746F72282223222B652B225F626F647922293B613F612E696E6E657248544D4C3D722E68746D6C3A617065782E64656275672E77';
wwv_flow_imp.g_varchar2_table(6) := '61726E2822426F647920656C656D656E74206E6F7420666F756E643A222C652B225F626F647922293B636F6E737420743D6E2E717565727953656C6563746F72286023247B657D5F68656164696E6760293B722E68656164696E672626743F742E746578';
wwv_flow_imp.g_varchar2_table(7) := '74436F6E74656E743D722E68656164696E673A617065782E64656275672E7761726E28227468652068656164696E67207761736E27742073656E742066726F6D206261636B656E64206F722048656164696E6720656C656D656E74206E6F7420666F756E';
wwv_flow_imp.g_varchar2_table(8) := '6422297D2C6572726F723A28652C722C6E293D3E7B617065782E64656275672E6572726F7228224572726F722072656672657368696E6720726567696F6E3A222C722C6E297D7D297D7D297D3B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(12400925145583245)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_file_name=>'plugin_index.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E6D657465722D636F6E7461696E6572207B6D617267696E2D746F703A20313570783B6D617267696E2D626F74746F6D3A20313070783B7D2E7265636F72642D6E616D657B666F6E742D73697A653A20736D616C6C3B7D2E6D657465722D686561646572';
wwv_flow_imp.g_varchar2_table(2) := '207B646973706C61793A20666C65783B6A7573746966792D636F6E74656E743A2073706163652D6265747765656E3B6D617267696E2D626F74746F6D3A203570783B7D2E76616C75652D74657874207B746578742D616C69676E3A2072696768743B636F';
wwv_flow_imp.g_varchar2_table(3) := '6C6F723A20726762283130322C203130312C203939293B666F6E742D73697A653A20736D616C6C3B7D2E6D657465722D6261722D636F6E7461696E6572207B6261636B67726F756E642D636F6C6F723A20236539656365663B626F726465722D72616469';
wwv_flow_imp.g_varchar2_table(4) := '75733A203170783B6865696768743A20313270783B6F766572666C6F773A2068696464656E3B7D2E6D657465722D626172207B6865696768743A20313030253B626F726465722D7261646975733A203170783B7D2E6D657465722D6261722D636F6E7461';
wwv_flow_imp.g_varchar2_table(5) := '696E6572207B6261636B67726F756E642D636F6C6F723A205247422032313920323136203231353B626F726465722D7261646975733A203170783B6865696768743A20313070783B6F766572666C6F773A2068696464656E3B6D617267696E2D746F703A';
wwv_flow_imp.g_varchar2_table(6) := '203870783B706F736974696F6E3A2072656C61746976653B7D2E6D657465722D7469636B207B706F736974696F6E3A206162736F6C7574653B6865696768743A20313030253B77696474683A203270783B746F703A20303B6261636B67726F756E642D63';
wwv_flow_imp.g_varchar2_table(7) := '6F6C6F723A7267622834332C2034332C203433293B7D2E726567696F6E2D7469746C657B666F6E742D73697A653A20323070783B666F6E742D7765696768743A203530303B7D2E726567696F6E2D7375627469746C657B666F6E742D73697A653A203134';
wwv_flow_imp.g_varchar2_table(8) := '70783B636F6C6F723A207267622838332C2038332C203833293B7D';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(12908901367893625)
,p_plugin_id=>wwv_flow_imp.id(12349959918101827)
,p_file_name=>'comparative_meter_bars_plugin.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
