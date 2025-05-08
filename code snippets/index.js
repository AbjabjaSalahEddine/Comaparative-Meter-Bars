window.comparative_meter_bars = window.comparative_meter_bars || {};

window.comparative_meter_bars.init = (pRegionId, pAjaxId) => {
  apex.debug.info(
    "Initializing comparative_meter_bars for region:",
    pRegionId,
    pAjaxId
  );

  apex.region.create(pRegionId, {
    type: "comparative_meter_bars",
    refresh: () => {
      apex.server.plugin(
        pAjaxId,
        {},
        {
          dataType: "json",
          success: (data) => {
            const regionEl = document.getElementById(pRegionId);
            apex.debug.info("AJAX Data:", data);

            if (!regionEl) {
              apex.debug.warn("Region element not found:", pRegionId);
              return;
            }

            const bodyEl = regionEl.querySelector("#" + pRegionId + "_body");

            if (bodyEl) {
              bodyEl.innerHTML = data.html;
            } else {
              apex.debug.warn("Body element not found:", pRegionId + "_body");
            }

            const headingEl = regionEl.querySelector(`#${pRegionId}_heading`);

            if (data.heading && headingEl) {
              headingEl.textContent = data.heading;
            } else {
              apex.debug.warn(
                "the heading wasn't sent from backend or Heading element not found"
              );
            }
          },
          error: (jqXHR, textStatus, errorThrown) => {
            apex.debug.error(
              "Error refreshing region:",
              textStatus,
              errorThrown
            );
          },
        }
      );
    },
  });
};
