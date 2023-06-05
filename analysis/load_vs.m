% A script to load in the relevant data from the SpineML output.
%
% This script is designed to load the data generated by experiment 0
% of the VentralStream SpineML model.
%
% All the data is returned in a structure called model_data.
%
% Usually called something like this:
%
% model_data = load_ocm ('/home/seb/src/SpineML_2_BRAHMS/temp/Ventral_Stream_e0');
%
function model_data = load_vs (output_base_path)

    isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;

    model_log_path = [output_base_path '/log/'];
    model_run_path = [output_base_path '/run/'];
    model_model_path = [output_base_path '/model/'];

    % Load in activation state vars for SpineML/SpineCreator model
    [V1_p_edges, count] = load_sc_data ([model_log_path 'V1_p_edges_y_log.bin'], 22500);
    V1_p_edges = reshape (V1_p_edges, 150, 150, []);

    [V1_r_edges, count] = load_sc_data ([model_log_path 'V1_r_edges_y_log.bin'], 22500);
    V1_r_edges = reshape (V1_r_edges, 150, 150, []);

    [World, count] = load_sc_data ([model_log_path 'World_y_log.bin'], 22500);
    World = reshape (World, 150, 150, []);

    [V2_p_lines, count] = load_sc_data ([model_log_path 'V2_p_lines_y_log.bin'], 22500);
    V2_p_lines = reshape (V2_p_lines, 150, 150, []);

    [V2_r_lines, count] = load_sc_data ([model_log_path 'V2_r_lines_y_log.bin'], 22500);
    V2_r_lines = reshape (V2_r_lines, 150, 150, []);

    [V2_pPp_rPr, count] = load_sc_data ([model_log_path 'V2_pPp_rPr_y_log.bin'], 22500);
    V2_pPp_rPr = reshape (V2_pPp_rPr, 150, 150, []);

    [V2_pPp_rMr, count] = load_sc_data ([model_log_path 'V2_pPp_rMr_y_log.bin'], 22500);
    V2_pPp_rMr = reshape (V2_pPp_rMr, 150, 150, []);

    [V2_pMp_rPr, count] = load_sc_data ([model_log_path 'V2_pMp_rPr_y_log.bin'], 22500);
    V2_pMp_rPr = reshape (V2_pMp_rPr, 150, 150, []);

    [V2_pMp_rMr, count] = load_sc_data ([model_log_path 'V2_pMp_rMr_y_log.bin'], 22500);
    V2_pMp_rMr = reshape (V2_pMp_rMr, 150, 150, []);


    % Now build up the structure to return.
    keySet = {'V1_p_edges', ...
              'V1_r_edges', ...
              'V2_p_lines', ...
              'V2_r_lines', ...
              'V2_pPp_rPr', ...
              'V2_pPp_rMr', ...
              'V2_pMp_rPr', ...
              'V2_pMp_rMr', ...
              'World'};
    valueSet = {V1_p_edges, ...
                V1_r_edges, ...
                V2_p_lines, ...
                V2_r_lines, ...
                V2_pPp_rPr, ...
                V2_pPp_rMr, ...
                V2_pMp_rPr, ...
                V2_pMp_rMr, ...
                World};

    model_data = struct();
    for i = 1:numel (keySet)
        model_data.(keySet{i}) = valueSet{i};
    end

end