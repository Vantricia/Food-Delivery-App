// Marketing.js
import React, { useState } from 'react';
import './marketing.css'

const Marketing = () => {
  const [subject, setSubject] = useState('');
  const [message, setMessage] = useState('');
  const [recipients, setRecipients] = useState('');
  const [status, setStatus] = useState('');



  const handleSendEmail = (e) => {
    e.preventDefault();
    const config = {
        SecureToken: "d91f290a-9fef-4ec2-99e9-d01815038291",
        To : recipients,
        From : "wongvantricia@gmail.com",
        Subject : subject,
        Body : message,
      };
    window.Email.send(config);
    setStatus('Email sent successfully!');
  };

  return (
    <div className="marketing-container">
      <h1>Marketing</h1>
      <form onSubmit={handleSendEmail}>
        <div className="form-group">
          <label htmlFor="recipients">Recipients (comma-separated emails)</label>
          <input
            type="text"
            id="recipients"
            value={recipients}
            onChange={(e) => setRecipients(e.target.value)}
            placeholder="e.g., user1@example.com, user2@example.com"
            required
          />
        </div>
        <div className="form-group">
          <label htmlFor="subject">Subject</label>
          <input
            type="text"
            id="subject"
            value={subject}
            onChange={(e) => setSubject(e.target.value)}
            placeholder="Email Subject"
            required
          />
        </div>
        <div className="form-group">
          <label htmlFor="message">Message</label>
          <textarea
            id="message"
            value={message}
            onChange={(e) => setMessage(e.target.value)}
            placeholder="Write your message here..."
            rows="10"
            required
          />
        </div>
        <button type="submit" className="send-button">Send Email</button>
        {status && <p className="status">{status}</p>}
      </form>
    </div>
  );
};

export default Marketing;
