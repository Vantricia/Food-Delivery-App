import React from 'react';

const Analytics = () => {
  return (
    <div>
      <h1>Analytics</h1>
      <div style={{ width: '100%', height: '80vh' }}>
        <iframe
          src="https://lookerstudio.google.com/embed/reporting/8b3ad982-aaba-4ff9-a36a-a692537bfa5c/page/kIV1C"
          style={{ width: '100%', height: '100%', border: '1px solid #ccc' }}
          title="Looker Studio Report"
          allowFullScreen
        ></iframe>
      </div>
    </div>
  );
};

export default Analytics;