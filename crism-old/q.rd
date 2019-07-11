<resource schema="crism">
<!--        <meta name="title">CRISM data from Earth Server 2</meta>-->
        <meta name="title">CRISM</meta>
        <meta name="description">
List of coverages accessible through PlanetServer2 
(http://access.planetserver.eu/) obtained by Compact Reconnaissance 
Imaging Spectrometer for Mars (CRISM) on Mars Reconnaissance Orbiter (MRO).
CRISM at full spatial and spectral resolution maps at 15–19 m/pixel, 
362–3920 nm at 6.55 nm/channel. CRISM contains two sensor arrays: S for 
VNIR (107 channels from 364.6 to 1056.0 nm) and L for IR (438 channels 
from 1001.3 to 3936.8 nm).
Granule_gid corresponds to the observation mode:
FRT - Full Resolution Targeted, HRL - Half Resolution Targeted
HRS - Half Resolution Short, EPF - Emission Phase Function,
FRS - Full Resolution Short, MSW - Multispectral Window,
MSV - Multispectral VNIR, MSP - Multispectral Survey,
HSP - Hyperspectral Mapping, HSV - Hyperspectral VNIR,
ATO - Along-Track Oversampled, ATU - Along-Track Undersampled,
TOD - Tracking Optical Depth, FFC - Flat Field Calibration.
Murchie, Scott, et al. "Compact reconnaissance imaging spectrometer for 
Mars (CRISM) on Mars reconnaissance orbiter (MRO)." Journal of Geophysical 
Research: Planets 112.E5 (2007). DOI: 10.1029/2006JE002682
        </meta>
        <meta name="creationDate">2016-03-30T00:00:00</meta>
        <meta name="subject">___</meta>
        <meta name="subject">__</meta>

        <meta name="creator.name">Mikhail Minin</meta>
        <meta name="contact.name">Mikhail Minin</meta>
        <meta name="contact.email">m.minin@jacobs-university.de</meta>
        <meta name="instrument">CRISM</meta>

        <meta name="subjects">Mars, spectroscopy, infrared, remote sensing</meta>

        <meta name="facility"></meta>

        <meta name="source">planetserver.eu</meta>
        <meta name="contentLevel">Research</meta>
        <meta name="type">Catalog</meta>  <!-- or Archive, Survey -->

        <meta name="coverage">
        </meta>

        <table id="epn_core">
                <mixin spatial_frame_type="body">//epntap2#table-2_0</mixin>
                <meta name="description">
                CRISM data from Planet Server 2: http://access.planetserver.eu/
                </meta>
                <stc>
		     Polygon UNKNOWNFrame [s_region]
                </stc>
                <index columns="s_region" method='GIST'/>

		<column name="access_url" type="text" ucd="meta.ref.url;meta.file" verbLevel="1" description="URL of the data file." /> 
		<column name="access_format" type="text" description="File format type" ucd="meta.code.mime" verbLevel="1"/> 
		<column name="access_estsize" type="integer" unit="kbyte" description="Estimate file size in kbyte" ucd="phys.size;meta.file" verbLevel="1"/>

                <column name="thumbnail_url" type="text" ucd="meta.ref.url;meta.file" description="URL of an image preview" />

<column name="bib_reference" type="text" ucd="meta.bib.bibcode" verbLevel="1" description="doi bibcode" />

<!--optional-->
<column name="solar_longitude_min" type="double precision" unit="deg" verbLevel="1" description="Min Solar longitude Ls (location on orbit / season)" ucd="pos.posAng;pos.heliocentric;stat.min" />
<column name="solar_longitude_max" type="double precision" unit="deg" verbLevel="1" description="Max Solar longitude Ls (location on orbit / season)" ucd="pos.posAng;pos.heliocentric;stat.max" />

<!--non-standard-->
                <column name="sensor_id" type="text" ucd="meta.note;meta.main" tablehead="sensor id" verbLevel="1" description="non standard" />
                <column name="image_width" type="integer" description="image width" ucd="meta.note;meta.main" tablehead="image width" verbLevel="1" unit="pix" /> 
                <column name="image_height" type="integer" ucd="meta.note;meta.main" tablehead="image height" verbLevel="1" description="image height" unit="pix" />

                <column name="subgranule_url" type="text" ucd="meta.ref.url" verbLevel="1" description="Link to a web application to extract data for CASSIS" />

                <publish sets="ivo_managed" />
        </table>

        <data id="import">
                <sources>data/crism28052017d.csv</sources>
		<csvGrammar>
			<rowfilter procDef="//products#define">
				<bind name="table">"\schema.epn_core"</bind>
			</rowfilter>
		</csvGrammar>
                <make table="epn_core">
			<rowmaker idmaps="*">
				<var key="c1min" source="Westernmost_longitude" />
				<var key="c1max" source="Easternmost_longitude" />
				<var key="c2min" source="Minimum_latitude" />
				<var key="c2max" source="Maximum_latitude" />
				<var key="granule_uid" source="footprint" />

				<var key="s_region">'Polygon ICRS '+' '.join([str(item) for sublist in zip([float(x) for x in \
                                                    (@granule_uid.split(' ')[1:-2:2]+[@granule_uid.split(' ')[1]])],[float(x) for x in \
                                                    (@granule_uid.split(' ')[2:-2:2]+[@granule_uid.split(' ')[2]])]) for item in sublist])</var>


				<var key="spatial_frame_type">"body"</var>
				<var key="processing_level">3</var>

				<var key="granule_uid" source="name" />
				<var key="granule_gid">(@granule_uid)[0:3]</var>
				<var key="obs_id">(@granule_uid)[3:11]</var>
                                <var key="dataproduct_type">"sc"</var>
				<var key="sensor_id">(@granule_uid)[20:21]</var>

				<var key="access_url">('http://access.planetserver.eu:8080/rasdaman/ows?&amp;SERVICE=WCS&amp;VERSION=2.0.1&amp;REQUEST=GetCoverage&amp;COVERAGEID=') + (@granule_uid).lower() + ('&amp;FORMAT=image/tiff')</var>
				<var key="target_name">"Mars"</var>
				<var key="target_class">"planet"</var>

				<var key="access_format">"application/x-geotiff"</var>

				<var key="spectral_resolution_min"  source="dimE" /> <!-- i needed a floating point variable, so took advantage of this column -->
				<var key="image_width">int(@spectral_resolution_min)</var>

				<var key="spectral_resolution_min" source="dimN" />
				<var key="image_height">int(@spectral_resolution_min)</var>


				<var key="access_estsize">[0.432*@image_width*@image_height,1.764*@image_width*@image_height][@sensor_id=='L']</var>

                                <var key="spectral_resolution_min">[ 2150714947773.1868, 290151792525.3139][@sensor_id=='L']</var>
                                <var key="spectral_resolution_max">[18041696022271.645, 2990145149266.6045][@sensor_id=='L']</var>

                                <var key="spectral_range_min">[283894373106060.6, 76151305120910.39][@sensor_id=='L']</var>
                                <var key="spectral_range_max">[822250296215030.1,299403233796065.1][@sensor_id=='L']</var>

                                <var key="spectral_sampling_step_min">[ 1771888268945.3125, 126910768664.07812][@sensor_id=='L']</var>
                                <var key="spectral_sampling_step_max">[14510950936840.75,  1945816521669.0625][@sensor_id=='L']</var>


				<var key="instrument_name">"CRISM"</var>
				<var key="instrument_host_name">"MRO"</var>

                                <var key="thumbnail_url">('http://access.planetserver.eu:8080/rasdaman/ows?service=WCS&amp;version=2.0.1&amp;request=ProcessCoverages&amp;query=for%20data%20in%20%28%20') + (@granule_uid).lower() + "%20%29%20return%20" + ('encode(%20%7B%20%0Ared%3A%20(int)((int)(255%20%2F%20(max(%20data.band_38)%20-%20min(data.band_38)))%20*%20(data.band_38%20-%20min(data.band_38)))%3B%20%0Agreen%3A%20(int)((int)(255%20%2F%20(max(%20data.band_27)%20-%20min(data.band_27)))%20*%20(data.band_27%20-%20min(data.band_27)))%3B%20%0Ablue%3A%20(int)((int)(255%20%2F%20(max(%20data.band_13)%20-%20min(data.band_13)))%20*%20(data.band_13%20-%20min(data.band_13)))%20%3B%20%0Aalpha%3A%20(int)((data.band_100%20%3E%200)%20*%20255)%7D%2C%20%22png%22%2C%20%22nodata%3D65535%22)','encode(%20{%20red:%20(int)((int)(255%20/%20(max(%20data.band_233)%20-%20min(data.band_233)))%20*%20(data.band_233%20-%20min(data.band_233)));%20green:%20(int)((int)(255%20/%20(max(%20data.band_78)%20-%20min(data.band_78)))%20*%20(data.band_78%20-%20min(data.band_78)));%20blue:%20(int)((int)(255%20/%20(max(%20data.band_13)%20-%20min(data.band_13)))%20*%20(data.band_13%20-%20min(data.band_13)))%20;%20alpha:%20(int)((data.band_100%20%3E%200)%20*%20255)},%20%22png%22,%20%22nodata=65535%22)')[@sensor_id=="L"]</var>

				<var key="subgranule_url">('http://epn1.epn-vespa.jacobs-university.de:8080/subGranule/index.html?cov=') + (@granule_uid).lower() + ('&amp;c1_min=') + str(@c1min) + ('&amp;c1_max=') + str(@c1max) + ('&amp;c2_min=') + str(@c2min) + ('&amp;c2_max=') + str(@c2max) + ('&amp;E_px=') + str(@image_width) + ('&amp;N_px=') + str(@image_height)  + ('&amp;sensor_id=') + (@sensor_id).lower()</var>

<var key="service_title">"CRISM"</var>
<var key="creation_date">"2016-1-1"</var>
<var key="modification_date">"2016-1-1"</var>
<var key="release_date">"2016-1-1"</var>
<var key="measurement_type">"phys.luminosity;phys.angArea;em.wl"</var>

<var key="bib_reference">"10.1029/2006JE002682"</var>

<var key="incidence_max" source="Incidence_angle" />
<var key="incidence_min" source="Incidence_angle" />

<var key="phase_max" source="Phase_angle" />
<var key="phase_min" source="Phase_angle" />

<var key="c1_resol_min">(@c1max-@c1min)/@image_width</var>
<var key="c1_resol_max">@c1_resol_min</var>

<var key="c2_resol_min">(@c2max-@c2min)/@image_height</var>
<var key="c2_resol_max">@c2_resol_min</var>

<var key="time_min" source="UTC_start_time" />
<var key="time_max" source="UTC_stop_time" />

<var key="emergence_min" source="Emission_angle" />
<var key="emergence_max" source="Emission_angle" />


<var key="solar_longitude_min" source="Solar_longitude" />
<var key="solar_longitude_max" source="Solar_longitude" />


				<apply procDef="//epntap2#populate-2_0" name="fillepn">
<bind name="processing_level">@processing_level</bind>
					<bind name="target_name">@target_name</bind>
					<bind name="target_class">@target_class</bind>
					<bind name="instrument_host_name">@instrument_host_name</bind>
					<bind name="instrument_name">@instrument_name</bind>
					<bind name="granule_uid">@granule_uid</bind>
					<bind name="granule_gid">@granule_gid</bind>
					<bind name="obs_id">@obs_id</bind>
					<bind name="spatial_frame_type">"body"</bind>
					<bind name="access_format">@access_format</bind>

					<bind name="c1min">@c1min</bind>
					<bind name="c1max">@c1max</bind>
					<bind name="c2min">@c2min</bind>
					<bind name="c2max">@c2max</bind>
<bind name="service_title">@service_title</bind>
<bind name="creation_date">@creation_date</bind>
<bind name="modification_date">@modification_date</bind>
<bind name="release_date">@release_date</bind>

<bind name="incidence_max">@incidence_max</bind>
<bind name="incidence_min">@incidence_min</bind>

<bind name="phase_max">@phase_max</bind>
<bind name="phase_min">@phase_min</bind>

<bind name="spectral_resolution_min">@spectral_resolution_min</bind>

<!-- QUICK HACK TO MAKE THIS WORK -->

<bind name="s_region">@s_region</bind>
<bind name="processing_level">@processing_level</bind>
<bind name="dataproduct_type">@dataproduct_type</bind>
<bind name="target_name">@target_name</bind>
<bind name="target_class">@target_class</bind>
<bind name="spectral_resolution_min">@spectral_resolution_min</bind>
<bind name="spectral_resolution_min">@spectral_resolution_min</bind>
<bind name="spectral_resolution_min">@spectral_resolution_min</bind>
<bind name="spectral_resolution_max">@spectral_resolution_max</bind>
<bind name="spectral_range_min">@spectral_range_min</bind>
<bind name="spectral_range_max">@spectral_range_max</bind>
<bind name="spectral_sampling_step_min">@spectral_sampling_step_min</bind>
<bind name="spectral_sampling_step_max">@spectral_sampling_step_max</bind>
<bind name="measurement_type">@measurement_type</bind>
<bind name="c1_resol_min">@c1_resol_min</bind>
<bind name="c1_resol_max">@c1_resol_max</bind>
<bind name="c2_resol_min">@c2_resol_min</bind>
<bind name="c2_resol_max">@c2_resol_max</bind>
<bind name="time_min">@time_min</bind>
<bind name="time_max">@time_max</bind>
<bind name="emergence_min">@emergence_min</bind>
<bind name="emergence_max">@emergence_max</bind>


<!-- QUICK HACK TO MAKE THIS WORK ENDS HERE -->

				</apply>
			</rowmaker>
		</make>
        </data>
</resource>

