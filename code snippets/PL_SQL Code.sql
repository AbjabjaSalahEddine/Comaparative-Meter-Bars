-- Procedure to generate and loop through meter bars
procedure generate_meter_bars (
    p_region    in      apex_plugin.t_region,
    p_html      out     clob
) is
    l_context apex_exec.t_context;
    l_record_id varchar2(255);
    l_record_name varchar2(255);
    l_record_value number;
    l_tick_value number;
    l_max_value number;
    l_color varchar2(30);
    l_unit varchar2(30);
    l_percentage number;
    l_tick_position number;
    l_link varchar2(255);
    l_format varchar2(30);
    
    l_record_id_col_no     pls_integer;
    l_record_name_col_no   pls_integer;
    l_record_value_col_no  pls_integer;
    l_tick_value_col_no    pls_integer;
    l_max_value_col_no     pls_integer;
    l_color_col_no         pls_integer;
    l_unit_col_no          pls_integer;
    l_link_col_no          pls_integer;
    l_format_col_no        pls_integer;

begin
    l_context        := apex_exec.open_query_context(
        p_max_rows   => p_region.fetched_rows
    );
    -- Add subtitle once, before looping through rows
    p_html := p_html || '<div class="region-subtitle">' || apex_escape.html(p_region.attributes.get_varchar2('region_subtitle')) || '</div>';
    
    -- Set column positions
    l_record_id_col_no   := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2('record_id'));
    l_record_name_col_no := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2('record_name'));
    l_record_value_col_no := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2('record_value'));
    l_tick_value_col_no   := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2('tick_value'));
    l_max_value_col_no    := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2('max_value'));
    l_color_col_no        := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2('color'));
    l_unit_col_no         := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2('unit'));
    l_link_col_no         := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2('link'));
    l_format_col_no       := apex_exec.get_column_position(l_context, p_region.attributes.get_varchar2('format'));


    -- Loop through the rows in the provided column value list
    while apex_exec.next_row(p_context => l_context) loop
        -- Fetch values dynamically using the column mappings
        l_record_id       := apex_escape.html(apex_exec.get_varchar2(l_context, l_record_id_col_no));
        l_record_name     := apex_escape.html(apex_exec.get_varchar2(l_context, l_record_name_col_no));
        l_record_value    := to_number(apex_exec.get_number(l_context, l_record_value_col_no));
        l_tick_value      := to_number(apex_exec.get_number(l_context, l_tick_value_col_no));
        l_max_value       := to_number(apex_exec.get_number(l_context, l_max_value_col_no));
        l_color           := apex_escape.html(apex_exec.get_varchar2(l_context, l_color_col_no));
        l_unit            := apex_escape.html(apex_exec.get_varchar2(l_context, l_unit_col_no));
        l_link            := apex_escape.html(apex_exec.get_varchar2(l_context, l_link_col_no));
        l_format          := apex_escape.html(apex_exec.get_varchar2(l_context, l_format_col_no));

        -- Calculate percentages
        l_percentage      := round((l_record_value / l_max_value) * 100);
        l_tick_position   := round((l_tick_value / l_max_value) * 100);

        -- Append the meter bar HTML
        p_html := p_html || '
            <div class="meter-container">
                <div class="meter-header">
                    <a href="' || l_link || '" class="record-name">' || l_record_name || '</a>
                    <span class="value-text">' || to_char(l_record_value, l_format) || ' ' || l_unit || '</span>
                </div>
                <div class="meter-bar-container">
                    <div class="meter-bar" style="width:' || l_percentage || '%; background-color:' || l_color || ';"></div>
                    <div class="meter-tick" style="left:' || l_tick_position || '%;"></div>
                </div>
            </div>
        ';
    end loop;

    apex_exec.close(l_context);
end generate_meter_bars;


-- render procedure
procedure render (
    p_region              in apex_plugin.t_region,
    p_plugin              in apex_plugin.t_plugin,
    p_param               in apex_plugin.t_region_render_param,
    p_result              in out apex_plugin.t_region_render_result
) is
    l_region_static_id varchar2(255);
    l_html clob := ''; -- Initialize l_html to an empty string
begin

    l_region_static_id := p_region.static_id;
    sys.htp.p('<div id="' || l_region_static_id || '_body">');

    apex_javascript.add_onload_code(
        'window.comparative_meter_bars.init(`' || l_region_static_id || '`,`' || apex_plugin.get_ajax_identifier || '`)' 
    );

    -- Call the generate_meter_bars function to generate HTML
    generate_meter_bars(
        p_region   => p_region,
        p_html              => l_html
    );

    -- Output the accumulated HTML
    sys.htp.p(l_html);
    sys.htp.p('</div>');
end render;

-- ajax_region procedure
procedure ajax_region (
    p_plugin in            apex_plugin.t_plugin,
    p_region in            apex_plugin.t_region,
    p_param  in            apex_plugin.t_region_ajax_param,
    p_result in out nocopy apex_plugin.t_region_ajax_result )
as
    l_context apex_exec.t_context;
    l_html clob := ''; -- Initialize l_html to an empty string
begin 

    -- Call the generate_meter_bars function to generate HTML
    generate_meter_bars(
        p_region        => p_region,
        p_html          => l_html
    );

    apex_json.open_object;
    apex_json.write('heading', p_region.title);
    apex_json.write('html', l_html);
    apex_json.close_object;
    apex_json.close_all;
end ajax_region;
