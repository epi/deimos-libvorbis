module deimos.vorbis.codec;

import core.stdc.config;

extern (C):

struct vorbis_info
{
    int version_;
    int channels;
    c_long rate;
    c_long bitrate_upper;
    c_long bitrate_nominal;
    c_long bitrate_lower;
    c_long bitrate_window;
    void* codec_setup;
}

struct vorbis_dsp_state
{
    int analysisp;
    vorbis_info* vi;
    float** pcm;
    float** pcmret;
    int pcm_storage;
    int pcm_current;
    int pcm_returned;
    int preextrapolate;
    int eofflag;
    c_long lW;
    c_long W;
    c_long nW;
    c_long centerW;
    ogg_int64_t granulepos;
    ogg_int64_t sequence;
    ogg_int64_t glue_bits;
    ogg_int64_t time_bits;
    ogg_int64_t floor_bits;
    ogg_int64_t res_bits;
    void* backend_state;
}

struct vorbis_block
{
    float** pcm;
    oggpack_buffer opb;
    c_long lW;
    c_long W;
    c_long nW;
    int pcmend;
    int mode;
    int eofflag;
    ogg_int64_t granulepos;
    ogg_int64_t sequence;
    vorbis_dsp_state* vd;
    void* localstore;
    c_long localtop;
    c_long localalloc;
    c_long totaluse;
    alloc_chain* reap;
    c_long glue_bits;
    c_long time_bits;
    c_long floor_bits;
    c_long res_bits;
    void* internal;
}

struct alloc_chain
{
    void* ptr;
    alloc_chain* next;
}

struct vorbis_comment
{
    char** user_comments;
    int* comment_lengths;
    int comments;
    char* vendor;
}

void vorbis_info_init (vorbis_info* vi);
void vorbis_info_clear (vorbis_info* vi);
int vorbis_info_blocksize (vorbis_info* vi, int zo);
void vorbis_comment_init (vorbis_comment* vc);
void vorbis_comment_add (vorbis_comment* vc, const(char)* comment);
void vorbis_comment_add_tag (vorbis_comment* vc, const(char)* tag, const(char)* contents);
char* vorbis_comment_query (vorbis_comment* vc, const(char)* tag, int count);
int vorbis_comment_query_count (vorbis_comment* vc, const(char)* tag);
void vorbis_comment_clear (vorbis_comment* vc);
int vorbis_block_init (vorbis_dsp_state* v, vorbis_block* vb);
int vorbis_block_clear (vorbis_block* vb);
void vorbis_dsp_clear (vorbis_dsp_state* v);
double vorbis_granule_time (vorbis_dsp_state* v, ogg_int64_t granulepos);
const(char)* vorbis_version_string ();
int vorbis_analysis_init (vorbis_dsp_state* v, vorbis_info* vi);
int vorbis_commentheader_out (vorbis_comment* vc, ogg_packet* op);
int vorbis_analysis_headerout (vorbis_dsp_state* v, vorbis_comment* vc, ogg_packet* op, ogg_packet* op_comm, ogg_packet* op_code);
float** vorbis_analysis_buffer (vorbis_dsp_state* v, int vals);
int vorbis_analysis_wrote (vorbis_dsp_state* v, int vals);
int vorbis_analysis_blockout (vorbis_dsp_state* v, vorbis_block* vb);
int vorbis_analysis (vorbis_block* vb, ogg_packet* op);
int vorbis_bitrate_addblock (vorbis_block* vb);
int vorbis_bitrate_flushpacket (vorbis_dsp_state* vd, ogg_packet* op);
int vorbis_synthesis_idheader (ogg_packet* op);
int vorbis_synthesis_headerin (vorbis_info* vi, vorbis_comment* vc, ogg_packet* op);
int vorbis_synthesis_init (vorbis_dsp_state* v, vorbis_info* vi);
int vorbis_synthesis_restart (vorbis_dsp_state* v);
int vorbis_synthesis (vorbis_block* vb, ogg_packet* op);
int vorbis_synthesis_trackonly (vorbis_block* vb, ogg_packet* op);
int vorbis_synthesis_blockin (vorbis_dsp_state* v, vorbis_block* vb);
int vorbis_synthesis_pcmout (vorbis_dsp_state* v, float*** pcm);
int vorbis_synthesis_lapout (vorbis_dsp_state* v, float*** pcm);
int vorbis_synthesis_read (vorbis_dsp_state* v, int samples);
c_long vorbis_packet_blocksize (vorbis_info* vi, ogg_packet* op);
int vorbis_synthesis_halfrate (vorbis_info* v, int flag);
int vorbis_synthesis_halfrate_p (vorbis_info* v);
